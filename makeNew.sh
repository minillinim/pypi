#!/bin/sh
echo "Creating pypi project $1"
lc=$(echo $1 | awk '{print tolower($1)}')

mkdir -p bin
touch bin/$lc.py
chmod +x bin/$lc.py
mkdir -p docs

echo "v0.0.1, <date> -- Initial release." > CHANGES.txt
echo $1 > README.txt
echo "include *.txt" > MANIFEST.in
echo "recursive-include docs *.txt" >> MANIFEST.in

echo "from distutils.core import setup

setup(
    name='$1',
    version='0.0.1',
    author='Michael Imelfort',
    author_email='mike@mikeimelfort.com',
    packages=['$lc', '$lc.test'],
    scripts=['bin/$lc.py'],
    url='http://pypi.python.org/pypi/$1/',
    license='LICENSE.txt',
    description='$1',
    long_description=open('README.txt').read(),
    install_requires=[],
)" > setup.py

# license information (GPLv3 by default)
script_path="`dirname \"$0\"`"
cp $script_path/LICENSE.txt .

# make sw dir
mkdir -p $lc
touch $lc/__init__.py
mkdir -p $lc/test
touch $lc/test/__init__.py

echo "Done!
NEXT...

Edit the setup.py and CHANGES.txt and README.txt so that they make sense

Then...

python setup.py sdist
python setup.py register
python setup.py sdist upload
"
