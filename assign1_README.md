# UNIX Assignment#1

### 1. Folder and files representations

A description of files within this folder

* **fan_snp_combined_columns.txt** :  output from combining columns of both files( fang et al and snp_positions)
* **columns_and_lines_info.txt**: output lines and columns of both files( fang et al and snp_positions)
* **file_size_permissioninfo.txt**: output of file sizes information of both files( fang et al and snp_positions)

* **teosinte**: All the inspeceted and process data for teosinte
* **maize** : All the inspected and process data for maize
* **fang**: All the  priliminary prcessed files from fang_et_al genotypes
* **snp**: All the priliminary prcessed files from snp_positions

### 2.Data Inspections of both files 
    
''' created directory and files'''

*    mkdir Assignment1_$(date+%F)               
*    cp README.md fang_et_al_genotypes.txt snp_position.txt Unix_Assignment.md 
*    UNIX_Assignment_Template.md /work/LAS/jroche-lab/Urval/BCB546/assignments/ Assignment1_$(date+%F)
*    touch assign1_README.md
*   vi assign1_README.md 

''' started inserting the informations including commands''' 

*    by typing vi <filename>, then press "i" then quit using ':wq'

''' to check the files sizes and  permission of files'''

*   ls -lh fang_et_al_genotypes.txt snp_position.txt >file_size_permissioninfo.txt
*   cat file_size_permissioninfo.txt . #### The size of fang_et_al_genotypes.txt is 11MB and snp_position.txt 18KB.

''' check the lines and columns  of both files '''

*   wc fang_et_al_genotypes.txt  snp_position.txt > columns_and_lines_info.txt
*   cat columns_and_lines_info.txt          ###there are lines, words  and characters :  2783,2744038,11051939 in  fang_et_al_genotypes.txt and ,984,13198,82763 snp_position.txt

''' to check, create and merge std output of columns for both files'''

*   awk -F "\t" '{print NF ; exit}'  snp_position.txt >snp_column.txt
*   awk -F "\t" '{print NF ; exit}' fang_et_al_genotypes.txt > fand_columns.txt

''' to merge columns outpute of both files'''
    
*   cat fang_columns.txt snp_column.txt > fan_snp_combined_columns.txt ##there are total 986
*   columns in fang_et_al_genotypes.txt and 15 columns in snp_position.txt

### 3. Data processing of both files

'''' For obtaining collumns from snp_position text'''
    
*    cut -f 1,3,4 snp_position.txt > snp134.txt 
*    column -t snp134.txt > snp134_arangecolumn.txt      #### to align the columns 

''' created another files with only ZMMIL,ZMMMR,ZMMLR ZMPBA, ZMPIL, and ZMPJA group'''
    
*    grep -E "(ZMMLR|ZMMIL|ZMMMR)" fang_et_al_genotypes.txt >maize_group1.txt
*    grep -E "(ZMPBA|ZMPIL|ZMPJA)"fang_et_al_genotypes.txt > teosinte_group1.txt

'''' inspected  and tidying it up acquired data '''
    
*    grep "ZMMLR" maize_group1.txt  #### applied to all the groups for maize and teosinte
*    ls -lh maize_group1.txt teosinte_group1.txt
*    column -t maize_group1.txt > maize_group1a.txt
*    column -t teosinte_group1.txt >  teosinte_group1a.txt

''' then tranpose the maize_group1.txt and teosinte_group1'''
    
*    awk -f transpose.awk maize_group1.txt > transpose_maize1.txt
*    awk -f transpose.awk teosinte_group1.txt > transpose_teosinte1.txt
 
 * **Restart of some processing of the files.**

''' Since I could not get the SNP ID in the genotypes file, I restarted the process of obtaining maize and teosinte group after transpose it '''
    
*    grep "Sample_ID" fang_et_al_genotypes.txt > fang_header.txt    ##### obtain headers from maize/teosinte
*    cat fang_header.txt maize_group1.txt > merged_maize.txt
*    cat fang_header.txt teosinte_group1.txt > merged_teosinete1.txt
 
''' transpose the no headers files'''

*    awk -f transpose.awk merged_teosinete1.txt >transpose_teosinte.txt
*    awk -f transpose.awk merged_maize.txt >transpose_maize.txt
 
'''strips the headers from merged maize and teosinete file'''
    
*    tail -n +3 transpose_maize.txt > g_maize.txt
*    tail -n +3 transpose_teosinte.txt > g_teosinte.txt

''' to merge the files using "join" command used '''
    
*    join -1 1 -2 1 -t $'\t' --header snp134.txt g_maize.txt > final_maize.txt
*    join -1 1 -2 1 -t $'\t' --header snp134.txt g_teosinte.txt > final_teosinte.txt

''' sorted files by position, chromosomes # and obtained unknown as well as multiple positon files for maize and teosinte '''
    
*    tail -n +2 final_maize.txt | sort -k3,3n > final_maize1.txt
*    sort -k2,2n final_maize1.txt > final_maize1a.txt
*    sort -k2,2n -k3,3V -i final_maize.txt > sorted_maize.txt
*    sort -k2,2n -k3,3V -i final_teosinte.txt > sorted_teosinte1.txt
*    grep -E "(SNP_ID|multiple)" final_maize.txt > multiple_maize.txt
*    grep -E "(SNP_ID|unknown)" final_maize.txt > unknown_maize.tx
*    grep -E "(SNP_ID|multiple)" final_teosinte.txt > multiple_teosinte.txt
*    grep -E "(SNP_ID|unknown)" final_teosinte.txt > unknown_teosinte.txt


''' Then extracted chromosomes (1 to 10) base rows for maize and teosinte and output in files'''
    
*    head -n 1 sorted_maize.txt > chr1..10.txt | awk '{if(NF==1576 && $2=="2") print $0}' sorted_maize.txt >>chr1...10.txt
*    head -n 1 sorted_teosinte1.txt >chr1...10.txt | awk '{if(NF==978 && $2=="2") print $0}' sorted_teosinte1.txt >>chr1..10.txt
 
''' After creating each files , each chromosomes duplicates was created and to replace "?"
to "-" for maize and teosinte.'''
    
*    sed -i 's/?/-/g' *a.txt

'''After replacing, I sorted using the following commands for maize'''
    
*    tail -n +2 chr1a.txt | sort -k3,3nr >> chr1b.txt
*    head -n 1  chr2a.txt >chr2b.txt | tail -n +2 chr2a.txt | sort -k3,3nr >> chr2b.txt
*    head -n 1  chr2a.txt >chr2b.txt ; tail -n +2 chr2a.txt | sort -k3,3nr >> chr2b.txt
*    head -n 1  chr3a.txt >chr3b.txt ; tail -n +2 chr3a.txt | sort -k3,3nr >> chr3b.txt
*    head -n 1  chr4a.txt >chr4b.txt ; tail -n +2 chr4a.txt | sort -k3,3nr >> chr4b.txt
*    head -n 1  chr5a.txt >chr5b.txt ; tail -n +2 chr5a.txt | sort -k3,3nr >> chr5b.txt
*    head -n 1  chr6a.txt >chr6b.txt ; tail -n +2 chr6a.txt | sort -k3,3nr >> chr6b.txt
*    head -n 1  chr7a.txt >chr7b.txt ; tail -n +2 chr7a.txt | sort -k3,3nr >> chr7b.txt
*    head -n 1  chr8a.txt >chr8b.txt ; tail -n +2 chr8a.txt | sort -k3,3nr >> chr8a.txt
*    head -n 1  chr9a.txt >chr9b.txt ; tail -n +2 chr9a.txt | sort -k3,3nr >> chr9a.txt
*    head -n 1  chr10a.txt >chr10b.txt ; tail -n +2 chr10a.txt | sort -k3,3nr >> chr10b.txt
*    head -n 1  chr9a.txt >chr9b.txt ; tail -n +2 chr9a.txt | sort -k3,3nr >> chr9b.txt
*    head -n 1  chr8a.txt >chr8b.txt ; tail -n +2 chr8a.txt | sort -k3,3nr >> chr8b.txt

'''move chr#b files in decreasing folder and chr#a into increasing folder'''
 
*    mv chr*b* /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/maize/decreasing
*    mv chr*a* /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/maize/increasing


*   **Built a pipeline name as "script.sh" in teosinte folder to process several process at the same time.**

 '''for sorting and creating: the reason for  "#" infront of some command is to mute the command to run other commands("maximum efficiency"). In short, this is just an example script so might find some errors regarding commands. I fixed the error and submit it till I obtain the require informations'''

*    head -n 1 sorted_teosinte1.txt >chr1.txt | awk '{if(NF==978 && $2=="1") print $0}' sorted_teosinte1.txt >>chr1.txt
*    head -n 1 sorted_teosinte1.txt >chr2.txt | awk '{if(NF==978 && $2=="2") print $0}' sorted_teosinte1.txt >>chr2.txt
*    head -n 1 sorted_teosinte1.txt >chr3.txt | awk '{if(NF==978 && $2=="3") print $0}' sorted_teosinte1.txt >>chr3.txt
*    head -n 1 sorted_teosinte1.txt >chr4.txt | awk '{if(NF==978 && $2=="4") print $0}' sorted_teosinte1.txt >>chr4.txt
*    head -n 1 sorted_teosinte1.txt >chr5.txt | awk '{if(NF==978 && $2=="5") print $0}' sorted_teosinte1.txt >>chr5.txt
*    cp chr1.txt chr1a.txt; sed -i 's/?/-/g' chr1a.txt  
*    cp chr2.txt chr2a.txt; sed -i 's/?/-/g' chr2a.txt 
*    cp chr3.txt chr3a.txt; sed -i 's/?/-/g' chr3a.txt
*    cp chr4.txt chr4a.txt; sed -i 's/?/-/g' chr4a.txt 
*    cp chr5.txt chr5a.txt; sed -i 's/?/-/g' chr5a.txt
*    cp chr6.txt chr6a.txt; sed -i 's/?/-/g' chr6a.txt
*    cp chr7.txt chr7a.txt; sed -i 's/?/-/g' chr7a.txt
*    cp chr8.txt chr8a.txt; sed -i 's/?/-/g' chr8a.txt
*    cp chr9.txt chr9a.txt; sed -i 's/?/-/g' chr9a.txt 
*    cp chr10.txt chr10a.txt; sed -i 's/?/-/g' chr10a.txt  
*    mkdir decreasing increasing

*    head -n 1  chr10a.txt >chr10b.txt ; tail -n +2 chr10a.txt | sort -k3,3nr >> chr10b.txt
*    head -n 1  chr9a.txt >chr9b.txt ; tail -n +2 chr9a.txt | sort -k3,3nr >> chr9b.txt
*    head -n 1  chr8a.txt >chr8b.txt ; tail -n +2 chr8a.txt | sort -k3,3nr >> chr8b.txt
*    head -n 1  chr1a.txt >chr1b.txt ; tail -n +2 chr1a.txt | sort -k3,3nr >> chr1b.txt
*    head -n 1  chr2a.txt >chr2b.txt ; tail -n +2 chr2a.txt | sort -k3,3nr >> chr2b.txt
*    head -n 1  chr3a.txt >chr3b.txt ; tail -n +2 chr3a.txt | sort -k3,3nr >> chr3b.txt
*    head -n 1  chr4a.txt >chr4b.txt ; tail -n +2 chr4a.txt | sort -k3,3nr >> chr4b.txt
*    head -n 1  chr5a.txt >chr5b.txt ; tail -n +2 chr5a.txt | sort -k3,3nr >> chr5b.txt
*    head -n 1  chr6a.txt >chr6b.txt ; tail -n +2 chr6a.txt | sort -k3,3nr >> chr6b.txt
*    head -n 1  chr7a.txt >chr7b.txt ; tail -n +2 chr7a.txt | sort -k3,3nr >> chr7b.txt

*    mv *b* /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/teosinte/decreasing
*    cd /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/teosinte/decreasing
*    column  -t *.txt
*    cd /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/teosinte/increasing
*    column  -t *.txt
*    cd /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/maize/decreasing
*    column  -t *.txt
*   cd /work/LAS/jroche-lab/Urval/BCB546/assignments/Assignment1_2023-02-12/maize/increasing
*    column  -t *.txt


#### Please let me know if you have any question regarding the location or further informations about my files. Thank you!!!!