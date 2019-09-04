FROM debian:10-slim

# References
# https://github.com/rackerlabs/dockerstack/blob/master/keystone/openldap/Dockerfile
# https://github.com/acme/docker-openldap/blob/master/memberUid/Dockerfile
# https://github.com/larrycai/docker-openldap/blob/master/Dockerfile

LABEL maintainer="Leonard Sheng Sheng Lee <sheeeng@gmail.com>"

# https://github.com/hadolint/hadolint/wiki/DL4006#correct-code
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# install slapd in noninteractive mode
RUN apt-get update \
    && echo "slapd slapd/root_password password changeit" | debconf-set-selections \
    && echo "slapd slapd/root_password_again password changeit" | debconf-set-selections \
    && echo "slapd slapd/internal/adminpw password changeit" | debconf-set-selections \
    && echo "slapd slapd/internal/generated_adminpw password changeit" | debconf-set-selections \
    && echo "slapd slapd/password2 password changeit" | debconf-set-selections \
    && echo "slapd slapd/password1 password changeit" | debconf-set-selections \
    && echo "slapd slapd/domain string acme.local" | debconf-set-selections \
    && echo "slapd shared/organization string Acme" | debconf-set-selections \
    && echo "slapd slapd/backend string HDB" | debconf-set-selections \
    && echo "slapd slapd/purge_database boolean true" | debconf-set-selections \
    && echo "slapd slapd/move_old_database boolean true" | debconf-set-selections \
    && echo "slapd slapd/allow_ldap_v2 boolean false" | debconf-set-selections \
    && echo "slapd slapd/no_configuration boolean false" | debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive apt-get install \
        --assume-yes \
        --no-install-recommends \
        ldap-utils=2.4.47+dfsg-3 \
        slapd=2.4.47+dfsg-3 \
    && rm --force --recursive /var/lib/apt/lists/*

# ca-certificates is already the newest version (20190110).
# openssl is already the newest version (1.1.1c-1).

COPY configurations/*.ldif /tmp/

# TODO: Use initialization scripts if available.
# TODO: Deprecate this Dockerfile when initialization scripts are used.
# https://github.com/osixia/docker-openldap/issues/20

# Workaround DL3001 for `service slapd start` Command
# https://github.com/hadolint/hadolint/wiki/DL3001

RUN mkdir -p /var/ldap/acme \
    && chown --recursive openldap /var/ldap \
    && /etc/init.d/slapd start \
    && ldapadd -H ldapi:/// -f /tmp/ou.ldif -x -D "cn=admin,dc=acme,dc=local" -w changeit -v \
    && ldapadd -H ldapi:/// -f /tmp/groups.ldif -x -D "cn=admin,dc=acme,dc=local" -w changeit -v \
    && ldapadd -H ldapi:/// -f /tmp/users.ldif -x -D "cn=admin,dc=acme,dc=local" -w changeit -v \
    && rm --verbose /tmp/*.ldif

EXPOSE 389

CMD ["slapd", "-h", "ldap:///" ,"-g", "openldap", "-u", "openldap", "-d", "256"]

# ----------------------------------------------------------------------

# usage: slapd options
# -4		IPv4 only
# -6		IPv6 only
# -T {acl|add|auth|cat|dn|index|passwd|test}
#                 Run in Tool mode
# -c cookie	Sync cookie of consumer
# -d level	Debug level
# -f filename	Configuration file
# -F dir	Configuration directory
# -g group	Group (id or name) to run as
# -h URLs		List of URLs to serve
# -l facility	Syslog facility (default: LOCAL4)
# -n serverName	Service name
# -o <opt>[=val] generic means to specify options; supported options:
#         slp[={on|off|(attrs)}] enable/disable SLP using (attrs)
# -r directory	Sandbox directory to chroot to
# -s level	Syslog level
# -u user		User (id or name) to run as
# -V		print version info (-VV exit afterwards, -VVV print
#                 info about static overlays and backends)

# ----------------------------------------------------------------------

# Add or modify entries from an LDAP server
# usage: ldapadd [options]
# 	The list of desired operations are read from stdin or from the file
# 	specified by "-f file".
# Add or modify options:
#   -a         add values (default)
#   -c         continuous operation mode (do not stop on errors)
#   -E [!]ext=extparam	modify extensions (! indicate s criticality)
#   -f file    read operations from `file'
#   -M         enable Manage DSA IT control (-MM to make critical)
#   -P version protocol version (default: 3)
#   -S file    write skipped modifications to `file'
# Common options:
#   -d level   set LDAP debugging level to `level'
#   -D binddn  bind DN
#   -e [!]<ext>[=<extparam>] general extensions (! indicates criticality)
#              [!]assert=<filter>     (RFC 4528; a RFC 4515 Filter string)
#              [!]authzid=<authzid>   (RFC 4370; "dn:<dn>" or "u:<user>")
#              [!]chaining[=<resolveBehavior>[/<continuationBehavior>]]
#                      one of "chainingPreferred", "chainingRequired",
#                      "referralsPreferred", "referralsRequired"
#              [!]manageDSAit         (RFC 3296)
#              [!]noop
#              ppolicy
#              [!]postread[=<attrs>]  (RFC 4527; comma-separated attr list)
#              [!]preread[=<attrs>]   (RFC 4527; comma-separated attr list)
#              [!]relax
#              [!]sessiontracking
#              abandon, cancel, ignore (SIGINT sends abandon/cancel,
#              or ignores response; if critical, doesn't wait for SIGINT.
#              not really controls)
#   -h host    LDAP server
#   -H URI     LDAP Uniform Resource Identifier(s)
#   -I         use SASL Interactive mode
#   -n         show what would be done but don't actually do it
#   -N         do not use reverse DNS to canonicalize SASL host name
#   -O props   SASL security properties
#   -o <opt>[=<optparam>] general options
#              nettimeout=<timeout> (in seconds, or "none" or "max")
#              ldif-wrap=<width> (in columns, or "no" for no wrapping)
#   -p port    port on LDAP server
#   -Q         use SASL Quiet mode
#   -R realm   SASL realm
#   -U authcid SASL authentication identity
#   -v         run in verbose mode (diagnostics to standard output)
#   -V         print version info (-VV only)
#   -w passwd  bind password (for simple authentication)
#   -W         prompt for bind password
#   -x         Simple authentication
#   -X authzid SASL authorization identity ("dn:<dn>" or "u:<user>")
#   -y file    Read password from file
#   -Y mech    SASL mechanism
#   -Z         Start TLS request (-ZZ to require successful response)

# ----------------------------------------------------------------------
