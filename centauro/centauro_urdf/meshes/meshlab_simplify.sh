#!/bin/bash

for i in *.stl; do
	fn=$(basename "$i")
	meshlabserver -i "$i" -o "simplified/$fn" -s meshlab_simplify.mlx -om vn
done

