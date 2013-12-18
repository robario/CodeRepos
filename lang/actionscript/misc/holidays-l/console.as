package {
    import com.rails2u.utils.ObjectUtil;
    import flash.external.ExternalInterface;
    import flash.utils.getQualifiedClassName;

    public class console {
        public static const ALL:int = 0;
        public static const DEBUG:int = 2;
        public static const INFO:int = 4;
        public static const WARN:int = 6;
        public static const ERROR:int = 8;
        public static const FATAL:int = 1000;

        private static var _level:uint = console.ALL;

        public static function get level():uint {
            return console._level;
        }

        public static function set level(level:uint):void {
            switch (level) {
            case console.ALL:
            case console.DEBUG:
            case console.INFO:
            case console.WARN:
            case console.ERROR:
            case console.FATAL:
                break;
            default:
                console.fatal("invalid level");
                return;
            }
            console._level = level;
        }

        public static function debug(...args):void {
            if (console.level <= console.DEBUG) {
                console.call("console.debug", args);
            }
        }

        public static function info(...args):void {
            if (console.level <= console.INFO) {
                console.call("console.info", args);
            }
        }

        public static function warn(...args):void {
            if (console.level <= console.WARN) {
                console.call("console.warn", args);
            }
        }

        public static function error(...args):void {
            if (console.level <= console.ERROR) {
                console.call("console.error", args);
            }
        }

        public static function fatal(...args):void {
            if (console.level <= console.FATAL) {
                console.call("alert", [ObjectUtil.inspect.apply(null, [args])]);
            }
        }

        public static function log(...args):void {
            console.call("console.debug", args);
        }

        private static function call(method:String, args:Array):void {
            var arg:* = args.length == 1 ? args[0] : args;

            if (ExternalInterface.available) {
                try {
                    ExternalInterface.call("function(o,c){o.toString=function(){return c};"+method+"(o);}",
                                           ObjectUtil.clone(arg), getQualifiedClassName(arg));
                } catch(e:Error) {
                    ExternalInterface.call(method, ObjectUtil.inspect.apply(null, args));
                }
            } else {
                trace(ObjectUtil.inspect.apply(null, args));
            }
        }
    }
}
