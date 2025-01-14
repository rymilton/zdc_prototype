for nlayers in 10 15 20 25 30 40 50 60; do
    compactFile=zdc_prototype_${nlayers}_layers.xml;
    cat zdc_prototype_xml_template | sed 's/NLAYERS/'${nlayers}'/g' > $compactFile;
done

rm -rf build
mkdir build; cd build; cmake .. -DCMAKE_INSTALL_PREFIX=$EIC_SHELL_PREFIX; make; make install;

