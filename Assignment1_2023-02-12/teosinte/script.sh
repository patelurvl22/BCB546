#head -n 1 sorted_teosinte1.txt >chr1.txt | awk '{if(NF==978 && $2=="1") print $0}' sorted_teosinte1.txt >>chr1.txt
#head -n 1 sorted_teosinte1.txt >chr2.txt | awk '{if(NF==978 && $2=="2") print $0}' sorted_teosinte1.txt >>chr2.txt
##head -n 1 sorted_teosinte1.txt >chr3.txt | awk '{if(NF==978 && $2=="3") print $0}' sorted_teosinte1.txt >>chr3.txt
#head -n 1 sorted_teosinte1.txt >chr4.txt | awk '{if(NF==978 && $2=="4") print $0}' sorted_teosinte1.txt >>chr4.txt
#head -n 1 sorted_teosinte1.txt >chr5.txt | awk '{if(NF==978 && $2=="5") print $0}' sorted_teosinte1.txt >>chr5.txt
#cp chr1.txt chr1a.txt; sed -i 's/?/-/g' chr1a.txt  
#cp chr2.txt chr2a.txt; sed -i 's/?/-/g' chr2a.txt 
#cp chr3.txt chr3a.txt; sed -i 's/?/-/g' chr3a.txt
#cp chr4.txt chr4a.txt; sed -i 's/?/-/g' chr4a.txt 
#cp chr5.txt chr5a.txt; sed -i 's/?/-/g' chr5a.txt
#cp chr6.txt chr6a.txt; sed -i 's/?/-/g' chr6a.txt
#cp chr7.txt chr7a.txt; sed -i 's/?/-/g' chr7a.txt
##cp chr8.txt chr8a.txt; sed -i 's/?/-/g' chr8a.txt
#cp chr9.txt chr9a.txt; sed -i 's/?/-/g' chr9a.txt 
#cp chr10.txt chr10a.txt; sed -i 's/?/-/g' chr10a.txt  
#mkdir decreasing increasing

head -n 1  chr10a.txt >chr10b.txt ; tail -n +2 chr10a.txt | sort -k3,3nr >> chr10b.txt
head -n 1  chr9a.txt >chr9b.txt ; tail -n +2 chr9a.txt | sort -k3,3nr >> chr9b.txt
head -n 1  chr8a.txt >chr8b.txt ; tail -n +2 chr8a.txt | sort -k3,3nr >> chr8b.txt
head -n 1  chr1a.txt >chr1b.txt ; tail -n +2 chr1a.txt | sort -k3,3nr >> chr1b.txt
head -n 1  chr2a.txt >chr2b.txt ; tail -n +2 chr2a.txt | sort -k3,3nr >> chr2b.txt
head -n 1  chr3a.txt >chr3b.txt ; tail -n +2 chr3a.txt | sort -k3,3nr >> chr3b.txt
head -n 1  chr4a.txt >chr4b.txt ; tail -n +2 chr4a.txt | sort -k3,3nr >> chr4b.txt
head -n 1  chr5a.txt >chr5b.txt ; tail -n +2 chr5a.txt | sort -k3,3nr >> chr5b.txt
head -n 1  chr6a.txt >chr6b.txt ; tail -n +2 chr6a.txt | sort -k3,3nr >> chr6b.txt
head -n 1  chr7a.txt >chr7b.txt ; tail -n +2 chr7a.txt | sort -k3,3nr >> chr7b.txt

mv *b* /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/teosinte/decreasing
cd /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/teosinte/decreasing
column  -t *.txt
cd /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/teosinte/increasing
column  -t *.txt
cd /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/maize/decreasing_order
column  -t *.txt
cd /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/maize/increasing
column  -t *.txt
