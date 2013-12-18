(function() {
    if (typeof console != 'undefined') {
        return;
    }
    var NL = (navigator.appVersion.match(/\bMSIE\b/) ? '\r' : '\n');
    function _CREATE_CONSOLE(level) {
        return function(message) {
            alert('[' + level.toUpperCase() + '] ' + message + NL);
        };
    }

    window.console = {
        debug: _CREATE_CONSOLE('debug'),
        error: _CREATE_CONSOLE('error'),
        info: _CREATE_CONSOLE('info')};
    window.console.VERSION = 0.01;
})();

/*

=head1 NAME

console - define console object when there is no FireBug.

=head1 SYNOPSIS

  JSAN.use('console');
  
  or
  
  <script type="text/javascript" src="console.js"></script>

=head1 DESCRIPTION

=head2 Class Properties

=head2 Constructor

=head1 TODO

None.

=head1 SEE ALSO

FireBug
L<http://www.joehewitt.com/software/firebug/>

=head1 AUTHOR

Hironori Yoshida <yoshida@cpan.org>

=head1 COPYRIGHT

  Copyright (c) 2006, Hironori Yoshida <yoshida@cpan.org>. All rights reserved.
  This module is free software; you can redistribute it and/or modify it
  under the terms of the Artistic license. Or whatever license I choose,
  which I will do instead of keeping this documentation like it is.

=cut

*/
