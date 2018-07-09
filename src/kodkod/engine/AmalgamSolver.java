package kodkod.engine;

import java.util.Iterator;

import kodkod.ast.Formula;
import kodkod.ast.Relation;
import kodkod.engine.config.Options;
import kodkod.engine.fol2sat.HigherOrderDeclException;
import kodkod.engine.fol2sat.UnboundLeafException;
import kodkod.instance.Bounds;
import kodkod.instance.Tuple;

public class AmalgamSolver implements KodkodExtension{
	private AmalgamCore core;

	public AmalgamSolver() {
		this.core = new AmalgamCore();
	}
	public AmalgamSolver(Options options) {
		this.core = new AmalgamCore(options);
	}

	/* Core Methods */ 
	@Override
	public Options options() {
		return core.options;
	}
	@Override
	public Solution solve(Formula formula, Bounds bounds)
			throws HigherOrderDeclException, UnboundLeafException, AbortedException {
		return core.solve(formula, bounds);
	}
	@Override
	public void free() {
		core.free();
	}
	@Override
	public Solution current() {
		return core.current();
	}
	@Override
	public Solution diff() {
		return core.diff();
	}
	@Override
	public Solution diffCone() {
		return core.diffCone();
	}
	@Override
	public Solution diffAntiCone() {
		return core.diffAntiCone();
	}
	@Override
	public Solution shrink() {
		return core.shrink();
	}
	@Override
	public Solution minimize() {
		return core.minimize();
	}
	@Override
	public Solution grow() {
		return core.grow();
	}
	@Override
	public Solution maximize() {
		return core.maximize();
	}
	@Override
	public Solution augment(Relation r, Tuple fact) {
		return core.augment(r, fact);
	}
	@Override
	public Solution backtrack() {
		return core.backtrack();
	}

	/* Badly exposed things */
	public Bounds getBounds() {
		return core.translation.bounds();
	}
	public Solution getModel() {
		return core.model;
	}

	public SolutionIterator solveAll(final Formula formula, final Bounds bounds) 
			throws HigherOrderDeclException, UnboundLeafException, AbortedException {
		return new SolutionIterator(formula, bounds, core); 
	}
	public boolean usable() {
		return ((core.model.outcome() == null) || core.model.sat() == Boolean.TRUE);
	}
	public static final class SolutionIterator implements Iterator<Solution> {
		private AmalgamCore solver;
		Solution s = null;
		SolutionIterator(Formula formula, Bounds bounds, AmalgamCore solver) {
			this.solver = solver;
			solver.solve(formula, bounds);
		}
		public boolean hasNext() { return true; }
		
		// FIXME hard coded for class studies (true=min models, false=max models) 
		private enum StudyType {NONE, MINONLY, MAXONLY};
		// If NONE, default Alloy behavior. If MINONLY, Aluminum behavior. Etc.
		private final StudyType studyType = StudyType.NONE;
		private Solution refineHelper(Solution current) {
			if(studyType.equals(StudyType.MINONLY)) return solver.minimize();
			if(studyType.equals(StudyType.MAXONLY)) return solver.maximize();
			return current;
		}
		private Solution nextHelper() {
			if(studyType.equals(StudyType.MINONLY)) return solver.diffCone();
			if(studyType.equals(StudyType.MAXONLY)) return solver.diffAntiCone();
			return solver.diff();
		}
		
		public Solution next() {
			if(s==null) {
				s=solver.current();
				if(s.sat()) s = refineHelper(s);
			}
			else {
				s=this.next("diff");
			}
			return s;
		}
		public Solution next(String type) {
			if(type.startsWith("augment")) {
				String[] args = type.split("_");
				Bounds b = this.solver.translation.bounds();
				Relation rel = null;
				Tuple tup = null;
				for(Relation r : b.relations()) {
					// TODO bad string check
					if(r.toString().endsWith(args[1])) {
						rel = r;
					}
				}
				for(Tuple t : b.upperBound(rel)) {
					if(t.toString().equals(args[2])) {
						tup = t;
					}
				}
				return s=solver.augment(rel, tup);
			}
			switch(type) {
			case "diff" : {
				s = nextHelper();
				if(s.sat()) s = refineHelper(s);
				return s;
			}
			case "diffCone" : return s=solver.diffCone();
			case "diffAntiCone" : return s=solver.diffAntiCone();
			case "shrink" : return s=solver.shrink();
			case "minimize" : return s=solver.minimize();
			case "grow" : return s=solver.grow();
			case "maximize" : return s=solver.maximize();
			case "coverage" : return s=solver.coverage();
			default : throw new IllegalArgumentException("Unsupported enumerate operation: "+type);
			}
		}
		public void remove() { throw new UnsupportedOperationException(); }
	}
} 
