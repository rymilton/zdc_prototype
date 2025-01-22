outdir=sim_out/
mkdir -p $outdir

scan_layers(){
    particle=$1
    energy=$2
    #for nlayers in 10 15 20 25 30 40 50 60; do
    for nlayers in 60; do
	compactFile=${DETECTOR_PATH}/zdc_prototype_${nlayers}_layers.xml
	simfile=${outdir}/${particle}_${energy}_GeV_${nlayers}_layers.edm4hep.root
	physicsList='FTFP_BERT_HP'
	macroFile="./macros/${particle}_${energy}_GeV.mac"

	npsim --compactFile ${compactFile} --runType run --enableG4GPS --macroFile ${macroFile}\
	      --outputFile ${simfile} --physicsList=${physicsList} &

    done
    wait
}

#scan_layers Fe56 56
#scan_layers e+ 4
#scan_layers proton 2
#scan_layers mu- 2
#scan_layers C12 56
#scan_layers Al27 56
scan_layers Ca40 56
