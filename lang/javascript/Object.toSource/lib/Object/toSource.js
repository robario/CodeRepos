(function() {
    if (typeof Object.prototype.toSource != 'undefined') {
        return;
    }
    var toSource = function() {
        if (typeof this == 'string' || this instanceof String) {
            return '"' + this + '"';
        }
        if (typeof this == 'number' || this instanceof Number) {
            return this;
        }
        if (typeof this == 'function' || this instanceof Function) {
            var r = this.toString();
            return r.replace(/function\(/, 'function \(').replace(/\)\{/, ') {');
        }

        if (this instanceof Array) {
            var r = [];
            for(var i = 0, len = this.length; i < len; i++) {
                if (typeof this[i] == 'undefined') {
                    r.push('undefined');
                } else if (this[i] == null) {
                    r.push('null');
                } else {
                    r.push(toSource.apply(this[i]));
                }
            }
            return '[' + r.join(', ') + ']';
        }

        if (this instanceof Object) {
            var r = [];
            for (var i in this) {
                if (i == 'toSource') {
                    continue;
                }
                if (typeof this[i] == 'undefined') {
                    r.push(i + ':undefined');
                } else if (this[i] == null) {
                    r.push(i + ':null');
                } else {
                    r.push(i + ':' + this[i].toSource());
                }
            }
            return '{' + r.join(', ') + '}';
        }

        return this;
    };
    var toSourceFirst = function() {
        if (typeof this == 'string' || this instanceof String) {
            return '(new String("' + this + '"))';
        }

        if (typeof this == 'number' || this instanceof Number) {
            return '(new Number(' + this + '))';
        }

        if (!(this instanceof Array) && this instanceof Object) {
            return '(' + toSource.apply(this) + ')';
        }

        return toSource.apply(this);
    };

    Object.prototype.toSource = toSourceFirst;
})()

Object.prototype.toSource.VERSION = '0.0.1';

/*

=head1 NAME

Object.toSource - toSource

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TODO

=head1 SEE ALSO

=head1 AUTHOR

Hironori Yoshida <yoshida@cpan.org>

=head1 COPYRIGHT

The MIT License
Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

=cut

*/
