import haxe.Unserializer;
import sys.FileSystem;
import sys.io.File;
import haxe.Exception;

class UnserializeTool {
	static var path:String;
	static var unserializerInstance:Unserializer;
	static var currentValue:Dynamic;
	static var finished:Bool = false;
	
	public static function main():Void {
		trace(Sys.args());
		if(Sys.args().length != 1){
			error("Invalid number of arguments");
		}
		path = Sys.args()[0];
		if(!FileSystem.exists(path)){
			error("Input file does not exist");
		}
		
		unserializerInstance = new Unserializer(File.getContent(path));
		
		while(!finished){
			try {
				currentValue = unserializerInstance.unserialize();
			} catch (e:Exception){
				finished = true;
			}
			if(!finished) trace(currentValue);
		}
	}
	
	static function error(message:String){
		Sys.stderr().writeString(message + "\n");
		Sys.stderr().flush();
		Sys.stderr().close();
		Sys.exit(1);
	}
}
