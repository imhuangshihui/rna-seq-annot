#!/bin/bash

source ~/.bashrc

conda activate huangshihui

for num in {6..7}

do 

hisat2 -p 20 --dta -x ./index/v2 -1 //data14/huangshihui/v2_annotation/rna_seq/clean/zhangjihong/CHG03046${num}_R1clean.fastq.gz -2 //data14/huangshihui/v2_annotation/rna_seq/clean/zhangjihong/CHG03046${num}_R2clean.fastq.gz -S zhangCHG${num}.sam
done
