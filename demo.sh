mkdir /code/cpp/build
pushd /code/cpp/build
cmake ..
make
make install
popd

python3 -m pip install ./code/pysaxpy
python3 demo.py
