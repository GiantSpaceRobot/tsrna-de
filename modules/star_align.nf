#!/usr/bin/env nextflow

/*====================
Align reads using STAR
====================*/

params.min_read_length = 16

process STAR_ALIGN {

    //tag "$reads_file.simpleName"

    input:
    path reads
    //tuple val(filename), path(reads)
    path star_db
    //path gtf

    output:
    path("*Aligned.out.sam"), emit: sam
    path("*Log.final.out"), emit: log_final
    path("*_Stats.log"), emit: sam_stats
    //path("*Log.out"), emit: log_out
    //path("*Log.progress,out"), emit: log_progress
    //path "*.version.txt", emit: version
    

    script:
    // Nextflow variables are defined using !{var} and bash using ${var}
    //suffix="trimmed.fq.gz"
    //filename=${reads%"$suffix"} 
    //filename=${reads%"trimmed.fq.gz"} 
    //echo "${filename}"
    """
    STAR \\
        --genomeDir ${star_db} \\
        --readFilesIn ${reads} \\
        --runThreadN ${task.cpus} \\
        --outSAMattributes AS nM HI NH \\
        --outFilterMultimapScoreRange 0 \\
        --outFilterMatchNmin ${params.min_read_length} \\
        --outFileNamePrefix ${reads}_ \\
        --readFilesCommand zcat
    grep 'Number of input reads' ${reads}_Log.final.out \\
        | sed -r 's/\\s+//g' \\
        | awk -F '|' '{print \$2}' \\
        > ${reads}_Stats.log
    echo ' reads; of these:' >> ${reads}_Stats.log
    """
}