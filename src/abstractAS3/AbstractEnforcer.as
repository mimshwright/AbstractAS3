package abstractAS3
{
	/**
	 * A utility class for helping to enforce runtime Abstract class and 
	 * method checking. Use either AbstractEnforcer.enforceConstructor() to
	 * make a class abstract or AbstractEnforcer.enforceMethod() to force a
	 * method to be overrridden. 
	 * 
	 * @author Mims Wright
	 */
	public class AbstractEnforcer
	{
		/**
		 * When called within a constructor, ensures that the constructor
		 * cannot be instantiated unless the constructor is being called from a subclass.
		 * Other code placed in the constructor will be executed by the subclass.
		 *  
		 * @param self A reference to the object whose constructor is being called.
		 * @param abstractClass The class to make abstract. The class of the constructed object.
		 * @throws org.as3lib.errors.AbstractError If self is an instance of abstractClass (and not a subclass).
		 *
		 * @example 
		 * <listing version="3.0">
		 * // superclass (abstract)
		 * package {
		 * 		public class AbstractClass {
		 *	 		// this constructor cannot be called (without throwing an error) unless AbstractClass is subclassed. 
		 * 			public function AbstractClass() {
		 * 				AbstractEnforcer.enforceConstructor(this, AbstractClass);
		 *				// other constructor code here.
		 *			}
		 *		}
		 *  }
		 * 
		 * package {
		 * 		public class SubClass {
		 * 			public function SubClass () {
		 * 				super(); // doesn't throw an error.
		 * 			}
		 * 		}
		 * }
		 * </listing>
		 */ 
		public static function enforceConstructor(self:Object, abstractClass:Class):void {
			if (strictIs(self, abstractClass)) {
				throw (new AbstractError(AbstractError.CONSTRUCTOR_ERROR));
			}
		}
		
		/**
		 * When called within a method, will throw an error if the method is
		 * called, thus forcing it to be overridden in a subclass to be used.
		 * Note, there can be no default implementation of an abstract method so 
		 * using super.methodName() will still throw the error.
		 * 
		 * @throws org.as3lib.errors.AbstractError If the method is called without being overridden.
		 * 
		 * @example <listing version="3.0">
		 * package {
		 * 		public class AbstractClass {
		 * 			// this method must be overridden.
		 * 			public function abstractMethod() {
		 * 				AbstractEnforcer.enforceMethod();
		 *			}
		 *		}
		 * }
		 * </listing>
		 */
		public static function enforceMethod (messageText:String = ""):void {
			throw (new AbstractError(AbstractError.METHOD_ERROR + " " + messageText));
		}
	}
}