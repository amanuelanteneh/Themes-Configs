#!/bin/bash
#plot for [i=0:(STATS_blocks - 2)] 'nSphereVolumeC.dat' using 1:3 index i title sprintf("Radius: %1.2f",i*0.05+1)
rm outputGnuScript.gnu
if [ $# != 5 ]; 
then 
	echo "Enter arguments in this order:
    data file name, output file name, [ points (p), smooth bezier (s), or lines (l) ], [ splot (s) or plot (p) ], multiplot (y or n) "
	exit
fi
echo "Enter plot title"
read plotTitle
echo "Enter x-axis label"
read xAxisLabel
echo "Enter y-axis label"
read yAxisLabel
echo "Which data file column is X?"
read xCol
echo "Which data file column is Y?"
read yCol
echo "# GNU plot script for Comp Phys I" >> "outputGnuScript.gnu"
echo "set terminal png" >> "outputGnuScript.gnu" 
echo "set output '$2'" >> "outputGnuScript.gnu" # $2 is second command line argument (output filename)
echo "set title '$plotTitle'" >> "outputGnuScript.gnu"  
echo "set xlabel '$xAxisLabel'" >> "outputGnuScript.gnu"
echo "set ylabel '$yAxisLabel'" >> "outputGnuScript.gnu"
if [ $5 = "y" ]; #if doing multiplot
then
	echo "Enter range of loop (i=s:f)"
	read range
	if [ $4 = "s" ]; #if doing surface plot (splot)
	then
		echo "Enter z-axis label"
		read zAxisLabel
		echo "Which data file column is Z?"
		read zCol
		echo "set zlabel '$zAxisLabel'" >> "outputGnuScript.gnu"
		if [ $3 = "p" ]; # $3 is third command line arg
		then
			echo "stats '$1'" >> "outputGnuScript.gnu"			
			echo "splot for [$range] '$1' using $xCol:$yCol:$zCol index i title sprintf(\"Radius: %1.2f\",i*0.05+1)" >> "outputGnuScript.gnu" 
		fi
		if [ $3 = "l" ];
		then
			echo "stats '$1'" >> "outputGnuScript.gnu"			
			echo "splot for [$range] '$1' using $xCol:$yCol:$zCol index i title sprintf(\"Radius: %1.2f\",i*0.05+1) w l" >> "outputGnuScript.gnu"
		fi
		echo "unset output" >> "outputGnuScript.gnu"
		echo "set terminal x11" >> "outputGnuScript.gnu"
		gnuplot outputGnuScript.gnu # run script		
		exit 
	fi

	if [ $3 = "p" ]; 
	then
		echo "stats '$1'" >> "outputGnuScript.gnu"			
		echo "plot for [$range] '$1' using $xCol:$yCol index i title sprintf(\"Radius: %1.2f\",i*0.05+1)" >> "outputGnuScript.gnu" 
	fi
	if [ $3 = "s" ]; 
	then
		echo "stats '$1'" >> "outputGnuScript.gnu"			
		echo "plot for [$range] '$1' using $xCol:$yCol index i title sprintf(\"Radius: %1.2f\",i*0.05+1) smooth bezier" >> "outputGnuScript.gnu"
	fi
	if [ $3 = "l" ];
	then
		echo "stats '$1'" >> "outputGnuScript.gnu"			
		echo "plot for [$range] '$1' using $xCol:$yCol index i title sprintf(\"Radius: %1.2f\",i*0.05+1) with line" >> "outputGnuScript.gnu"
	fi
	echo "unset output" >> "outputGnuScript.gnu"
	echo "set terminal x11" >> "outputGnuScript.gnu"
	gnuplot outputGnuScript.gnu # run script		
	exit
fi
if [ $5 = "n" ]; #if not doing multiplot
then
	if [ $4 = "s" ]; #if doing surface plot (splot)
	then
		echo "Enter z-axis label"
		read zAxisLabel
		echo "Which data file column is Z?"
		read zCol		
		echo "set zlabel '$zAxisLabel'" >> "outputGnuScript.gnu"
		if [ $3 = "p" ]; 
		then
			echo "splot '$1' using $xCol:$yCol:$zCol" >> "outputGnuScript.gnu" # $1 is first command line argument (data file name)
		fi

		if [ $3 = "l" ];
		then
			echo "plot '$1' using $xCol:$yCol with lines" >> "outputGnuScript.gnu"
		fi
		echo "unset output" >> "outputGnuScript.gnu"
		echo "set terminal x11" >> "outputGnuScript.gnu"
		gnuplot outputGnuScript.gnu # run script		
		exit
	fi
	if [ $3 = "p" ]; 
	then
		echo "plot '$1' using $xCol:$yCol" >> "outputGnuScript.gnu" # $1 is first command line argument (data file name)
	fi
	if [ $3 = "s" ]; 
	then
		echo "plot '$1' using $xCol:$yCol smooth bezier" >> "outputGnuScript.gnu"
	fi
	if [ $3 = "l" ];
	then
		echo "plot '$1' using $xCol:$yCol with lines" >> "outputGnuScript.gnu"
	fi
	echo "unset output" >> "outputGnuScript.gnu"
	echo "set terminal x11" >> "outputGnuScript.gnu"
	gnuplot outputGnuScript.gnu # run script		
	exit
fi

