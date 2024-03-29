# Usar 'perl ex1.pm'

use strict;
use warnings;
use Getopt::Long;
use Bio::Seq;
use Bio::SeqIO;
use Bio::PrimarySeqI;

my $file_name = 'sequence.gb';    

GetOptions ('f=s' => \$file_name);     

my $input_file = Bio::SeqIO->new(-file => $file_name,   
                                 -format => 'genbank'
                                );
$file_name = substr $file_name, 0, -3; 
my $output_file = Bio::SeqIO->new( -file => ">$file_name.fas",  
                                   -format => 'fasta',
                                  );

print 'Creando archivo...';

while (my $seq = $input_file->next_seq) {   
    if(!$seq->validate_seq($seq->seq)) {    
        die "************ ERROR: SECUENCIA INVALIDA";
    }
    my @prots = Bio::SeqUtils->translate_6frames($seq);
    $output_file->write_seq(@prots);
 }


print "Archivo terminado! \n Resultados en: $file_name.fas \n";
