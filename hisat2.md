_突然想起是否需要用masked之后的基因组：/data14/wangzhiheng/final_v2/EDTA
RNA-seq数据：/data4/Longmi4_rna_seq_
# 1.对RNA-seq数据做质控
~~
cd /data4/Longmi4_rna_seq/lipinghua
conda activate huangshihui
mkdir ./fastqc_out
fastqc -o ./fastqc_out -t 10 *fastq.gz    
-o 指定文件输出目录，必须得提前建立好
-t 指定线程数
报告分析Ref：
https://zhuanlan.zhihu.com/p/20731723 北大生物学博士
https://zhuanlan.zhihu.com/p/136999851 农大遗传学博士
~~
## 使用fastp做质控
> fastp -i 双端测序输入文件1.fastq.gz -I 双端测序输入文件2.fastq.gz -o 输出文件1clean.fastq.gz -O 输出文件2clean.fastq.gz
使用NCBI上下载的sra文件，要先转换为fastq文件 sra_to_fastq.sh

# 2.hisat2比对
## 建立索引
vi hisat2_build.sh
  #!/bin/bash
  
  conda activate huangshihui
  
  hisat2-build -p 4 longmi_v2.fa v2

得到文件：v2.1.$i.ht2,$1=1,2,3,4,5,6,7,8 位于/data14/huangshihui/v2_annotation/index
## hisat2比对
hisat2 -p 20 --dta -x ./index/v2 -1 file_R1clean.fastq.gz -2 file_R2clean.fastq.gz -S file.sam
-p 线程数
-x 索引文件名
-1，-2 双端测序的fastq文件
-S 生成的sam文件
--dta 下游使用stringtie组装需要用到此参数
可使用for循环批量提交 for_hisat2_align.sh
## sam_to_bam 排序
用conda安装的samtools遇到如下报错：
samtools: error while loading shared libraries: libcrypto.so.1.0.0: cannot open shared object file: No such file or directory
原因：现在samtools的版本已经在1.9以上了，但是conda安装的samtools版本依然是1.7
解决：conda install -c bioconda samtools=1.9 --force-reinstall（参考https://blog.csdn.net/zhangjunya/article/details/108235796）
conda activate samtools 
samtools sort -@ 20 -o file.bam file.sam
-@ 指定线程数
-o 输出结果bam文件的名称
## StringTie转录本组装






