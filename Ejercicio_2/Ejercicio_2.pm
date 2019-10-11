# Usar 'perl ex2.pm [--f archivo] [--db base_de_datos] [--l] con --l para ejecutarlo localmente, en ese caso, deberias bajar la base y hacer un makeblastdb.

use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;
use Bio::PrimarySeqI;
use Bio::Tools::Run::StandAloneBlastPlus;
use Getopt::Long;


my $file_name = 'sequence.fas';      
my $db = 'swissprot';                   
my $local = 0;
GetOptions ('f=s' => \$file_name,   
            'db=s' => \$db,        
            'l' => \$local);      

my $remote = 1 - $local;                     # Base de datos remota por default #

print '- Archivo: ', $file_name, "\n";
print '- Base de datos: ', $db;
print $remote?' (Remota)':' (Local)', "\n";

my $output_file_name = substr $file_name, 0, -4;           
$output_file_name .= '.blast';

my $blast = Bio::Tools::Run::StandAloneBlastPlus->new(
   -db_name => $db,
   -remote => $remote,
);

print 'Creando archivo...';
my $result = $blast->blastp( -query => $file_name, -outfile => $output_file_name);
$blast->cleanup;
print "Archivo terminado! \n Resultados en: $output_file_name \n";
