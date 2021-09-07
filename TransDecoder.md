# 先从cufflink的输出结果开始
## 从转录本序列transcript.gtf中提取fasta文件
> /home/wangzhiheng/huangshihui/software/TransDecoder-v5.5.0/util/gtf_genome_to_cdna_fasta.pl ./hisat2_results_for_cufflink/cufflink_all/transcripts.gtf ./longmi_v2.fa > transcript.fasta
## GTF TO GFF
> /home/wangzhiheng/huangshihui/software/TransDecoder-v5.5.0/util/gtf_to_alignment_gff3.pl ./hisat2_results_for_cufflink/cufflink_all/transcripts.gtf > transcript.gff3
## 预测转录本中最长的开放阅读框，默认是识别长度至少为100个氨基酸的开放阅读框。你可以通过-m参数来降低这个值，但是要知道随着最小长度的变短，ORF预测的假阳性率迅速增长。
> /home/wangzhiheng/huangshihui/software/TransDecoder-v5.5.0/TransDecoder.LongOrfs -t transcript.fasta 
## DIAMOND在Swissprot蛋白数据库中进行搜索，寻找同源证据支持
> ./diamond makedb --in uniprot_sprot.fasta --db uniprot_sprot.fasta
>./diamond blastp -d uniprot_sprot.fasta -q ./transcript.fasta.transdecoder_dir/longest_orfs.pep --evalue 1e-5 --max-target-seqs 1 > blastp.outfmt6
## 预测可能的编码区
> /home/wangzhiheng/huangshihui/software/TransDecoder-v5.5.0/TransDecoder.Predict -t transcript.fasta --retain_blastp_hits blastp.outfmt6
## 生成基于参考基因组的编码区注释文件
> /home/wangzhiheng/huangshihui/software/TransDecoder-v5.5.0/util/cdna_alignment_orf_to_genome_orf.pl transcript.fasta.transdecoder.gff3 transcripts.gff3 transcript.fasta > transcript.fasta.transdecoder.genome.gff3




[使用TransDecoder寻找转录本中的编码区徐州更-推荐](https://www.jianshu.com/p/fdd547223ed5)
[swissprot database download](https://www.uniprot.org/downloads)
[TransDecoder官方文档](https://github.com/TransDecoder/TransDecoder/wiki)
[TransDecoder官方文档中文版](http://blog.chinaunix.net/uid-12084847-id-5747180.html)
[DIAMOND: 超快的蛋白序列比对软件](https://xuzhougeng.top/archives/Fast-and-sensitive-protein-alignment-using-diamond)





