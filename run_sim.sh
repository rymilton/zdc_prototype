#!/bin/bash

function print_the_help {
  echo "USAGE: ${0} -n <nevents> -part <"\"particle\""> -p <momentum> -thmin <theta_min> -thmax <theta_max> -dist <"\"dist\""> "
  echo "  OPTIONS: "
  echo "    -n,--nevents            Number of events"
  echo "    -part,--particle        particle type"
  echo "    -p, --energy     particle min. momentum (GeV)"
  exit
}
source setup_env.sh

# Input simulation parameters
particle="proton"
energy=120*GeV
num_events=100

while [ True ]; do
if [ "$1" = "--help" -o "$1" = "-h" ]; then
   print_the_help
   shift
elif [ "$1" = "-part" -o "$1" = "--particle" ]; then
   particle=$2
   shift 2 # past argument
elif [ "$1" = "-n" -o "$1" = "--nevents" ]; then
   num_events=$2
   shift 2 # past argument
elif [ "$1" = "-p" -o "$1" = "--energy" ]; then
   energy_min=$2
   shift 2 # past argument
else
   break
fi
done

simfile="zdc_prototype_proton.edm4hep.root"
# Input simulation parameters -- Proton
npsim \
   --compactFile ${DETECTOR_PATH}/${DETECTOR_CONFIG}.xml \
   --numberOfEvents ${num_events} \
   --outputFile ${simfile} \
   --enableGun --gun.particle ${particle} --gun.energy ${energy} || exit

eicrecon -Ppodio:output_collections=HcalFarForwardZDCRawHits,HcalFarForwardZDCRecHits,MCParticles ${simfile}