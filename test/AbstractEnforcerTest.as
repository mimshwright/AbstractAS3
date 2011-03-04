package 
{
	
	import flexunit.framework.Assert;
	
	import abstractAS3.*;

	public class AbstractEnforcerTest
	{
		[Test]
		public function testEnforceConstructor():void {
			try {
				var superClass:SuperClass = new SuperClass();
			} catch (error:AbstractError) {
				Assert.assertTrue("SuperClass cannot be instantiated and will throw an error.", error.message == AbstractError.CONSTRUCTOR_ERROR);
			}
			
			var subClass:SubClass = new SubClass();
			
			Assert.assertTrue("SubClass can be instantiated.", subClass is SuperClass); 
			Assert.assertTrue("super() funciton still works despite enforceConstructor()", subClass.value == SuperClass.SUPER_CLASS_VALUE);
		}

		[Test]
		public function testEnforceMethod():void {
			var subClass:SubClass = new SubClass();
			
			try {
				subClass.abstractMethodA();
			} catch (error:AbstractError) {
				Assert.assertTrue("Abstract methods will throw an error if they are not overridden.", error.message == AbstractError.METHOD_ERROR);
			}
			
			subClass.abstractMethodB();
			Assert.assertTrue("Abstract methods will throw no error if they are overridden.", subClass.value == SubClass.OVERRIDDEN_VALUE);
		}
	}
}

import org.as3lib.utils.AbstractEnforcer;

class SuperClass {
	public static const SUPER_CLASS_VALUE:int = 1;
	public var value:int;
	
	public function SuperClass () {
		AbstractEnforcer.enforceConstructor(this, SuperClass);
		// this value will be inhereted if the subclass calls super() in the constructor.
		value = SUPER_CLASS_VALUE;
	}
	
	public function abstractMethodA():void {
		AbstractEnforcer.enforceMethod();
	}
	public function abstractMethodB():void {
		AbstractEnforcer.enforceMethod();
	}
}

class SubClass extends SuperClass {
	public static const OVERRIDDEN_VALUE:int = 2;
	
	public function SubClass () {
		super();
	}
	
	override public function abstractMethodB():void {
		value = OVERRIDDEN_VALUE;
	}
}