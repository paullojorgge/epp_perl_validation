### Summary
The intent of this project is to validate the XML listed in the following RFC's:
1. [Extensible Provisioning Protocol (EPP)](https://tools.ietf.org/html/rfc5730)

2. [Extensible Provisioning Protocol (EPP) Domain Name Mapping](https://tools.ietf.org/html/rfc5731)

3. [Extensible Provisioning Protocol (EPP) Host Mapping](https://tools.ietf.org/html/rfc5732)

4. [Extensible Provisioning Protocol (EPP) Contact Mapping](https://tools.ietf.org/html/rfc5733)

### How to install
```
git clone https://github.com/paullojorgge/epp_perl_validation.git
cd epp_perl_validation
cpan -L local --installdeps .
```

### Execute
```
cd epp_perl_validation
perl bin/xsd_epp_validation.pl
```
