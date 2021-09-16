# 目的：用cufflink/stringtie+transdecoder跑出来的gff文件：
  # 1.gene区域的蛋白序列BUSCO值如何；
  # 2.统计注释信息，如基因的数量,mRNA,CDS,exon等等
## 1.测试gff文件中的蛋白序列BUSCO值
### 1.1 提取gene的区域并打印成bed格式(这一步很慢，建议后台脚本)
  cat transdecoder.cufflink.gff3 | awk '$3=="gene"{print $1,$4,$5,$3}'| tr ' ' '\t' > transdecoder.cufflink.gene.bed
### 1.2 bed文件进行排序
  bedtools sort -i transdecoder.cufflink.gene.bed > transdecoder.cufflink.gene.sort.bed
### 1.3 去除掉和TE区重合的部分，用EDTA的结果
  bedtools intersect -v -a transdecoder.cufflink.gene.sort.bed -b EDTA_sort.bed > transdecoder.cufflink.gene_intersect-v.bed
### 1.4 提取蛋白序列
  bedtools getfasta -fi final_v2.fa -bed v2{}_intersect-v.bed -fo v2{}_out.fa
  
### 1.5 计算BUSCO值
  busco -m geno -i cufflink_out.fa -l /data2/wangzhiheng/BUSCO/embryophyta_odb10/ -c 40 -o v2_cufflink_emb --offline

### 1.6RESULTS
![图片](https://user-images.githubusercontent.com/76728625/133548738-2c02b7a6-5f78-46e5-aa16-e42efe956f30.png)
![图片](https://user-images.githubusercontent.com/76728625/133548748-f58a3585-19c6-4107-ac2d-257ec052c261.png)

## 2.统计每个gff的注释信息
*去TE区前后cufflink.gff中gene的数量*
![图片](https://user-images.githubusercontent.com/76728625/133565255-490bb843-846c-4cf0-8cd6-ef4d728ec714.png)
![图片](https://user-images.githubusercontent.com/76728625/133568201-95f74d72-d397-4a78-b7d6-b066070dfb5d.png)

  cat transdecoder.stringtie.gene_intersect-v.bed | wc -l
  
  awk '$3==gene{print}' transdecoder.stringtie.gff3 | wc -l
  
*去TE区前后stringtie.gff中gene的数量*
![图片](https://user-images.githubusercontent.com/76728625/133566007-1aa936fc-79b5-4b11-baea-97a8cc4dfb8d.png)
![图片](https://user-images.githubusercontent.com/76728625/133568740-caabd5cf-76b0-4e0f-99f4-bfd5d85af36c.png)


## Ref.
[师兄跑的脚本路径](/data14/wangzhiheng/final_v2/exonerate/remove_TEs)

[BUSCO结果路径](/data14/huangshihui/v2_annotation/transdecoder_results_for_stringtie/v2_stringtie_emb)

[最全Bedtools使用说明--只看本文就够了](https://www.jianshu.com/p/f8bbd51b5199)

