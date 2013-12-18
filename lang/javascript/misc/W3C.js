/*@cc_on
// http://d.hatena.ne.jp/amachang/20071010/1192012056
eval((function(props) {
    var code = [];
    for (var i = 0, n = props.length; i < n; i++) {
        var prop = props[i];
        window['_'+prop] = window[prop];
        code.push(prop+'=_'+prop)
    }
    return 'var '+code.join(',');
})('document self top parent alert setInterval clearInterval setTimeout clearTimeout'.split(' ')));
@*/
if (typeof window.addEventListener == 'undefined') {
    (function() {
        var listeners = [];

        function event_preventDefault() {
            this.returnValue = false
        }

        function event_stopPropagation() {
            this.cancelBubble = true
        }

        function create_wrappedListener(currentTarget, listener) {
            return function(event) {
                event.target = event.srcElement;
                event.currentTarget = currentTarget;
                event.preventDefault = event_preventDefault;
                event.stopPropagation = event_stopPropagation;
                listener(event);
            };
        }

        function addEventListener(type, listener, useCapture) {
            var wrappedListener = create_wrappedListener(this, listener);
            var el = {element: this, type: type, listener: listener, useCapture: useCapture, wrappedListener: wrappedListener};
            listeners.push(el);
            el.element.attachEvent('on' + el.type, el.wrappedListener);
        }

        function removeEventListener(type, listener, useCapture) {
            for (var i = 0, n = listeners.length; i < n; ++i) {
                var el = listeners[i];
                if (el.element == this && el.type == type && el.listener == listener && el.useCapture == useCapture) {
                    el.element.detachEvent('on' + el.type, el.wrappedListener);
                    listeners.splice(i, 1);
                    break;
                }
            }
        }

        function dispatchEvent(event) {
            this.fireEvent('on' + event.type);
        }

        function create_document_getElementById() {
            var getElementById = document.getElementById;
            return function(id) {
                return correctElement(getElementById(id));
            };
        }

        function create_getElementsByTagName(element) {
            var getElementsByTagName = element.getElementsByTagName;
            return function(tagName) {
                var elements = getElementsByTagName(tagName);
                for (var i = 0, n = elements.length; i < n; ++i) {
                    correctElement(elements[i]);
                }
                return elements;
            };
        }

        function event_initMouseEvent(type) {
            this.type = type;
        }

        function document_createEvent(type) {
            var event = document.createEventObject();
            event.initMouseEvent = event_initMouseEvent;
            return event;
        }

        function element_onpropertychange(event) {
            var element = event.srcElement;
            switch (event.propertyName) {
            case 'style.opacity':
                element.style.filter = 'Alpha(opacity=' + (element.style.opacity * 100) + ')';
                break;
            default:
                break;
            }
        }

        function correctElement(element) {
            if (!element || typeof element.addEventListener != 'undefined') {
                return element;
            }
            element.addEventListener = addEventListener;
            element.removeEventListener = removeEventListener;
            element.dispatchEvent = dispatchEvent;
            if (!element.tagName || element.tagName.toLowerCase() != 'object') { // OBJECT#getElementsByTagName is strange.
                element.getElementsByTagName = create_getElementsByTagName(element);
            }
            element.attachEvent('onpropertychange', element_onpropertychange);
            return element;
        };

        function window_unload() {
            while (listeners.length) {
                var el = listeners[0];
                el.element.removeEventListener(el.type, el.listener, el.useCapture);
            }
        }

        correctElement(window);
        window.addEventListener('unload', window_unload, false);

        correctElement(document);
        document.createEvent = document_createEvent;
        document.getElementById = create_document_getElementById();
        // window.addEventListener('load', function() {document.getElementsByTagName('*')}, false);
    })();
}

if (typeof window.XMLHttpRequest == 'undefined') {
    (function() {
        function create_XMLHttpRequest() {
            var objs = ['Msxml2.XMLHTTP', 'Microsoft.XMLHTTP'];
            for (var i = 0; i < objs.length; ++i) {
                try {
                    new ActiveXObject(objs[i]);
                    return function() {
                        return new ActiveXObject(objs[i]);
                    };
                } catch (e) {
                }
            }
            return;
        }
        window.XMLHttpRequest = create_XMLHttpRequest();
    })();
}
