#fetch the metacat binary the first time you run this by uncommenting it
#wget -c http://knb.ecoinformatics.org/software/dist/metacat-bin-2.4.1.tar.gz -O metacat.tar.gz
docker build -t kartoza/metacat .
