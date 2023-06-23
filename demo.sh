cmake -B /code/cpp/build -S /code/cpp
cmake --build /code/cpp/build
cmake --install /code/cpp/build
rm -rf /code/cpp/build
ldconfig

python3 -m pip install ./code/pysaxpy
python3 demo.py
