cmake -B /code/cpp/saxpy/build -S /code/cpp/saxpy
cmake --build /code/cpp/saxpy/build
cmake --install /code/cpp/saxpy/build
#rm -rf /code/cpp/saxpy/build

cmake -B /code/cpp/saxpy_header_only/build -S /code/cpp/saxpy_header_only
cmake --build /code/cpp/saxpy_header_only/build
cmake --install /code/cpp/saxpy_header_only/build
#rm -rf /code/cpp/saxpy_header_only/build

ldconfig

python3 -m pip install ./code/pysaxpy
python3 demo.py
