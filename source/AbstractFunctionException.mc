import Toybox.Lang;

class AbstractFunctionException extends Exception {
    public function initialize() {
        Exception.initialize();
        mMessage = "Invalid call to abstract function";
    }
}
