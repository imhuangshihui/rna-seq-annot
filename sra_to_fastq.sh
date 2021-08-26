# 从conda安装sratoolkit
conda install -c daler sratoolkit

sra_to_fastq.sh
#!/bin/bash

source ~/.bashrc

conda activate huangshihui

for i in *sra
do
echo $i
fastq-dump --split-3 $i
done

其中--split-3参数代表着如果是单端测序就生成一个 .fastq文件，如果是双端测序就生成_1.fastq 和*_2.fastq 文件。

