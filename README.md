# -记录Longmi4_v2的基因组注释流程
~打算使用maker-p和进行重复序列注释、基因结构注释、基因功能注释的拆分~
## **fastp**对RNA数据进行质控
## **hisat2**进行比对
## 转录本组装：**Stringtie, Cufflinks**
## 每一个软件组装出来的不同转录本的gff文件用**TACO**进行合并和排序，默认参数
## **Transdecoder** 鉴定转录本的ORF
