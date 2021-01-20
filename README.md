# tsrna-de

A Nextflow pipeline for the identification, quantification and analysis of tRNA fragments in small/miRNA-seq datasets

## Basis

* Analyse all FASTQs
* trim and QC 
* align reads using STAR 
* collapse SAM multi-mappers
* count features
* collate using MultiQC

## Quickstart


### Installation (via new conda environment)
```
git clone https://github.com/GiantSpaceRobot/tsrna-de.git
nextflow run tsrna-de --species mouse --input_dir tsrna-de/ExampleData/ --layout tsrna-de/additional-files/Example_ExperimentLayout.csv --output_dir My_Results
```

### Analysing a single RNA-seq dataset
We have supplied data to test that the pipeline is functioning correctly:

```
nextflow run tsrna-de --species mouse --input tsrna-de/ExampleData/CytC_IP1.fastq.gz --output_dir My_Results
```

On finishing the run, the pipeline will generate PDFs and CSVs in the specified output directory

### Comparing two conditions (e.g. control vs treatment)
```
nextflow run tsrna-de --species mouse --input_dir tsrna-de/ExampleData/ --layout tsrna-de/additional-files/Example_ExperimentLayout.csv --output_dir My_Results
```

On finishing the run, the pipeline will generate PDFs and CSVs in the specified output directory

## More Information
### tsrna-de steps and parameters 
#### Steps:
* Execute tsrna-de 
  1. FASTQC 
  2. MULTIQC
  3. trim_galore
  4. STAR
  5. Collapse SAM files
  6. tRNA counts (using featureCounts)
  7. tsRNA counts (using SAM-to-tsRNAcount.py script in bin)
  8. Run DESeq2 on tsRNA counts
#### Parameters:
* Run the following for a breakdown of parameters:
`nextflow/tsrna-de --help`

## Contributors
* Paul Donovan, PhD

## License
This project is licensed under the MIT License.
