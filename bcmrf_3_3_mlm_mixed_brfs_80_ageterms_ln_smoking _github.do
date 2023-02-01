
mixed    lnsmk_numcigday i.male i.ethnicV2 c.mc_agel10 c.mc_agel10#c.mc_agel10 c.mc_cohortl10 c.mc_agel10#c.mc_agel10#c.mc_agel10 /// 
			          c.mc_cohortl10#c.mc_cohortl10 ///
					  i.ethnicV2#c.mc_agel10 ///
					  i.ethnicV2#c.mc_agel10#c.mc_agel10 ///
					  i.ethnicV2#c.mc_agel10#c.mc_agel10#c.mc_agel10 ///
					  i.ethnicV2#c.mc_cohortl10	    ///
					  i.ethnicV2#c.mc_cohortl10#c.mc_cohortl10	    ///
					  || _all: R.nhms  || cohortgrp: || stateV2:, var mle
matrix b = e(b)	
estimates store cig_AC	 
estat ic
matrix cig_AC = r(S)


predict v0_cig   u0_cig   w0_cig,   reffects  
predict v0se_cig u0se_cig w0se_cig, reses     
predict res_cig,                    residuals 
predict sres_cig,                   rstandard 


* APC effect on CIG 

forvalues n = 0/7 {
sum mc_agel10 age if cohortgrp8==`n'
}

* Cohort and Age Effect of CIG
margins if cohortgrp8==0, at(mc_agel10=(2.7(0.1)4)) expression(exp(predict(xb)))  
matrix list r(b)
matrix B_cohort0_cig = r(b)
matrix list r(table)
matrix T_cohort0_cig = r(table)

margins if cohortgrp8==1, at(mc_agel10=(1.7(0.1)4)) expression(exp(predict(xb)))  
matrix list r(b)
matrix B_cohort1_cig = r(b)
matrix list r(table)
matrix T_cohort1_cig = r(table)

margins if cohortgrp8==2, at(mc_agel10=(0.7(0.1)3.5)) expression(exp(predict(xb)))  
matrix list r(b)
matrix B_cohort2_cig = r(b)
matrix list r(table)
matrix T_cohort2_cig = r(table)

margins if cohortgrp8==3, at(mc_agel10=(-0.3(0.1)2.5)) expression(exp(predict(xb)))  
matrix list r(b)
matrix B_cohort3_cig = r(b)
matrix list r(table)
matrix T_cohort3_cig = r(table)

margins if cohortgrp8==4, at(mc_agel10=(-1.3(0.1)1.5)) expression(exp(predict(xb)))  
matrix list r(b)
matrix B_cohort4_cig = r(b)
matrix list r(table)
matrix T_cohort4_cig = r(table)

margins if cohortgrp8==5, at(mc_agel10=(-1.4(0.1)0.5)) expression(exp(predict(xb)))  
matrix list r(b)
matrix B_cohort5_cig = r(b)
matrix list r(table)
matrix T_cohort5_cig = r(table)

margins if cohortgrp8==6, at(mc_agel10=(-2.2(0.1)-0.5)) expression(exp(predict(xb)))  
matrix list r(b)
matrix B_cohort6_cig = r(b)
matrix list r(table)
matrix T_cohort6_cig = r(table)

margins if cohortgrp8==7, at(mc_agel10=(-2.2(0.1)-1.5)) expression(exp(predict(xb)))  
matrix list r(b)
matrix B_cohort7_cig = r(b)
matrix list r(table)
matrix T_cohort7_cig = r(table)


forvalues c = 0/7 {
generate mlm_cig_c`c' = .
}


local agecounter = 67
forvalues col = 1/14 {
replace mlm_cig_c0 = B_cohort0_cig[1,`col'] if mlm_age==`agecounter'
local ++agecounter
}


local agecounter = 57
forvalues col = 1/24 {
replace mlm_cig_c1 = B_cohort1_cig[1,`col'] if mlm_age==`agecounter'
local ++agecounter
}
	

local agecounter = 47
forvalues col = 1/29 {
replace mlm_cig_c2 = B_cohort2_cig[1,`col'] if mlm_age==`agecounter'
local ++agecounter
}


local agecounter = 37
forvalues col = 1/29{
replace mlm_cig_c3 = B_cohort3_cig[1,`col'] if mlm_age==`agecounter'
local ++agecounter
}


local agecounter = 27
forvalues col = 1/29 {
replace mlm_cig_c4 = B_cohort4_cig[1,`col'] if mlm_age==`agecounter'
local ++agecounter
}


local agecounter = 26
forvalues col = 1/20 {
replace mlm_cig_c5 = B_cohort5_cig[1,`col'] if mlm_age==`agecounter'
local ++agecounter
}


local agecounter = 18
forvalues col = 1/18 {
replace mlm_cig_c6 = B_cohort6_cig[1,`col'] if mlm_age==`agecounter'
local ++agecounter
}


local agecounter = 18
forvalues col = 1/8 {
replace mlm_cig_c7 = B_cohort7_cig[1,`col'] if mlm_age==`agecounter'
local ++agecounter
}


forvalues c = 0/1 {
sum mlm_cig_c`c'
local min`c' = r(min)
}

forvalues c = 2/7 {
sum mlm_cig_c`c'
local max`c' = r(max)
}
				
twoway 	(line mlm_cig_c0  mlm_age, connect(ascending) sort lcolor(black))  ///
		(line mlm_cig_c1  mlm_age, connect(ascending) sort lcolor(black))  ///
		(line mlm_cig_c2  mlm_age, connect(ascending) sort lcolor(black))  ///
		(line mlm_cig_c3  mlm_age, connect(ascending) sort lcolor(black))  ///
		(line mlm_cig_c4  mlm_age, connect(ascending) sort lcolor(black))  ///
		(line mlm_cig_c5  mlm_age, connect(ascending) sort lcolor(black))  ///
		(line mlm_cig_c6  mlm_age, connect(ascending) sort lcolor(black))  ///
		(line mlm_cig_c7  mlm_age, connect(ascending) sort lcolor(black))  ///
		 , ///
		text(`min0' 80 "1916", placement(sw)) ///
		text(`min1' 80 "1930", placement(nw)) ///
		text(`max2' 74 "1940", placement(nw)) ///
		text(`max3' 64 "1950", placement(nw)) ///
		text(`max4' 54 "1960", placement(nw)) ///
		text(`max5' 44 "1970", placement(nw)) ///
		text(`max6' 34 "1980", placement(nw)) ///
		text(`max7' 24 "1990", placement(nw)) ///
		ytitle("Predicted no. of cigarettes smoked/day") xtitle("Age") 						///
	    xscale(range(18 80) titlegap(2)) xlab(20(10)80) xmtick(##9) ///
		yscale(titlegap(2)) 										///
	    ylabel(,nogrid) legend(off) graphregion(color(white)) ylab(0(5)25)	///
	    title("B", size(medium)) xline(40, lcolor(gs11) lpattern(dash))




*Conditional age effect on CIG 

display "$S_DATE $S_TIME"
margins, at(mc_agel10=(-2.2(0.1)4) mc_cohortl10=0) expression(exp(predict(xb))) 
display "$S_DATE $S_TIME"


return list
matrix list r(b)
matrix B_mc_agel10_cig = r(b)

matrix list r(table)
matrix T_mc_agel10_cig = r(table)


generate mlm_cig_mcage = .
label variable mlm_cig_mcage "Margins of cig by age" 

local agecounter = 18
forvalues col = 1/63{
replace mlm_cig_mcage = B_mc_agel10_cig[1,`col'] if mlm_age==`agecounter'
local ++agecounter
}





* Conditional cohort effect on CIG 
display "$S_DATE $S_TIME"
margins, at(mc_cohortl10=(-4.4(0.1)3.7) mc_agel10=0) expression(exp(predict(xb)))  
display "$S_DATE $S_TIME"


return list

matrix list r(b)
matrix B_cohort_cig = r(b)
matrix list r(table)
matrix T_cohort_cig = r(table)


generate mlm_cig_chrt   = .
label variable mlm_cig_chrt "Margins of cig by cohort" 

local chrtcounter = 1916
forvalues col = 1/82{
replace mlm_cig_chrt = B_cohort_cig[1,`col'] if mlm_cohort==`chrtcounter' 
local ++chrtcounter
}


matrix tcig = J( 14, 1, .)


local row = 1
forvalues c = 0/13 {
sum u0_cig if cohortgrp==`c'
matrix tcig [`row', 1] = r(mean)
local ++row
}


matrix list tcig


generate mlm_cig_u0     = .

local row = 1
	forvalues c = 0/13{
	replace mlm_cig_u0 = tcig[`row', 1] if mlm_cohortgrp==`c'
	local ++row
	}	
	

generate  mlm_cig_chrtu0 = exp(ln(mlm_cig_chrt) + (mlm_cig_u0 * mlm_mccohortl10))
label var mlm_cig_chrtu0 "cig exp(ln margins + re*cohort)"




* Periods effect on CIG
display "$S_DATE $S_TIME"
margins, expression(exp(predict(xb))) over(nhms) 
display "$S_DATE $S_TIME"


return list
matrix list r(b)
matrix B_nhms_cig = r(b)

matrix list r(table)
matrix T_nhms_cig = r(table)


generate mlm_cig_nhms   = .
label variable mlm_cig_nhms "Margins of cig by nhms" 
replace  mlm_cig_nhms   = B_nhms_cig[1,1] if mlm_nhms==1996
replace  mlm_cig_nhms   = B_nhms_cig[1,2] if mlm_nhms==2006
replace  mlm_cig_nhms   = B_nhms_cig[1,3] if mlm_nhms==2011
replace  mlm_cig_nhms   = B_nhms_cig[1,4] if mlm_nhms==2015



matrix tcig2 = J( 4, 1, .)


sum v0_cig if nhms==1996
matrix tcig2 [1,1] = r(mean)
sum v0_cig if nhms==2006
matrix tcig2 [2,1] = r(mean)
sum v0_cig if nhms==2011
matrix tcig2 [3,1] = r(mean)
sum v0_cig if nhms==2015
matrix tcig2 [4,1] = r(mean)


matrix list tcig2


generate mlm_cig_v0 = .
replace  mlm_cig_v0 = tcig2[1,1] if mlm_nhms==1996
replace  mlm_cig_v0 = tcig2[2,1] if mlm_nhms==2006
replace  mlm_cig_v0 = tcig2[3,1] if mlm_nhms==2011
replace  mlm_cig_v0 = tcig2[4,1] if mlm_nhms==2015


generate mlm_cig_nhmsv0   = exp(ln(mlm_cig_nhms) + mlm_cig_v0)




*Conditional age effect on CIG, by males and females 
display "$S_DATE $S_TIME"
margins male, at(mc_agel10=(-2.2(0.1)4) mc_cohortl10=0) expression(exp(predict(xb))) 
display "$S_DATE $S_TIME"


return list
matrix list r(b)
matrix B_mc_agel102_cig = r(b)

matrix list r(table)
matrix T_mc_agel102_cig = r(table)


generate mlm_cig_mcage2 = .
label variable mlm_cig_mcage2 "Margins of cig by age & gender" 


* female
local agecounter = 18
forvalues colf = 1(2)126 {
replace mlm_cig_mcage2 = B_mc_agel102_cig[1,`colf'] if mlm_male==0 & mlm_age2==`agecounter'
local ++agecounter
}

* male
local agecounter = 18
forvalues colm = 2(2)126 {
replace mlm_cig_mcage2 = B_mc_agel102_cig[1,`colm'] if mlm_male==1 & mlm_age2==`agecounter'
local ++agecounter
}


twoway (line mlm_cig_mcage2 mlm_age2 if mlm_male==1, connect(ascending) sort msymbol(i) lpattern("l")) ///    
	   (line mlm_cig_mcage2 mlm_age2 if mlm_male==0, connect(ascending) sort msymbol(i) lpattern("-"))  ///
       ,legend(label(1 male) label(2 female))         					 		///
	   ytitle("Predicted no. of cigarettes smoked/day") xtitle("Age")                            		///											
	   xscale(range(18 80) titlegap(2)) xlab(20(10)80) xmtick(##9) legend(position(1) ring(0) col(1)) ///
	   yscale(titlegap(2)) 	///
	   ylabel(,nogrid) graphregion(color(white)) ylab(0(5)25) ///
	   title("C", size(medium))								





*Conditional cohort effect on CIG, by males and females 
display "$S_DATE $S_TIME"
margins male, at(mc_cohortl10=(-4.4(0.1)3.7) mc_agel10=0) expression(exp(predict(xb))) 
display "$S_DATE $S_TIME"		  


return list
matrix list r(b)
matrix B_cohort2_cig = r(b)

matrix list r(table)
matrix T_cohort2_cig = r(table)


generate mlm_cig_chrt2   = .
label variable mlm_cig_chrt2 "Margins of cig by cohort & gender"  

* female
local chrtcounter = 1916
forvalues colf = 1(2)164 {
replace mlm_cig_chrt2 = B_cohort2_cig[1,`colf'] if mlm_male2==0 & mlm_cohort2==`chrtcounter' 
local ++chrtcounter
}

* male
local chrtcounter = 1916
forvalues colm = 2(2)164 {
replace mlm_cig_chrt2 = B_cohort2_cig[1,`colm'] if mlm_male2==1 & mlm_cohort2==`chrtcounter'
local ++chrtcounter
}

					
generate mlm_cig_u02     = .


matrix tcig2 = J( 14, 1, .)


local row = 1
forvalues c = 0/13 {
sum u0_cig if cohortgrp==`c'
matrix tcig2 [`row', 1] = r(mean)
local ++row
}


matrix list tcig2


local row = 1
forvalues c = 0/13{
replace mlm_cig_u02 = tcig2[`row', 1] if mlm_cohortgrp2==`c'
local ++row
}



generate mlm_cig_chrtu02 = exp(ln(mlm_cig_chrt2) + (mlm_cig_u02  * mlm_mccohort2l10))



twoway (line mlm_cig_chrtu02 mlm_cohort2 if mlm_male2==1, connect(ascending) sort msymbol(i) lpattern("l")) ///    
	   (line mlm_cig_chrtu02 mlm_cohort2 if mlm_male2==0, connect(ascending) sort msymbol(i) lpattern("-"))  ///
       ,legend(label(1 male) label(2 female))         					 				///
	   ytitle("Predicted no. of cigarettes smoked/day + re") xtitle("Cohort")                    				///											
	   xscale(range(1910 1997) titlegap(2)) xlab(1910(20)2000) xmtick(##19) legend(position(5) ring(0) col(1)) 	///
	   yscale(titlegap(2)) 	///
	   ylabel(,nogrid) graphregion(color(white)) ylab(0(5)25)	///
	   title("E", size(medium))										





*Conditional age effect on CIG, by ethnics 
				
display "$S_DATE $S_TIME"
margins ethnicV2, at(mc_agel10=(-2.2(0.1)4) mc_cohortl10=0) expression(exp(predict(xb))) 
display "$S_DATE $S_TIME"


return list
matrix list r(b)
matrix B_mc_agel103_cig = r(b)

matrix list r(table)
matrix T_mc_agel103_cig = r(table)



generate mlm_cig_mcage3 = .
label variable mlm_cig_mcage3 "Margins of cig by age & ethnic"

*Malay
local agecounter = 18
forvalues colm = 1(5)315 {
replace mlm_cig_mcage3 = B_mc_agel103_cig[1,`colm'] if mlm_ethnic==1 & mlm_age3==`agecounter'
local ++agecounter
}
*Chinese
local agecounter = 18
forvalues colc = 2(5)315{
replace mlm_cig_mcage3 = B_mc_agel103_cig[1,`colc'] if mlm_ethnic==2 & mlm_age3==`agecounter'
local ++agecounter
}
*Indian
local agecounter = 18
forvalues coli = 3(5)315{
replace mlm_cig_mcage3 = B_mc_agel103_cig[1,`coli'] if mlm_ethnic==3 & mlm_age3==`agecounter'
local ++agecounter
}
*Other bumis
local agecounter = 18
forvalues colo = 4(5)315{
replace mlm_cig_mcage3 = B_mc_agel103_cig[1,`colo'] if mlm_ethnic==4 & mlm_age3==`agecounter'
local ++agecounter
}
*Others
local agecounter = 18
forvalues cols = 5(5)315{
replace mlm_cig_mcage3 = B_mc_agel103_cig[1,`cols'] if mlm_ethnic==5 & mlm_age3==`agecounter'
local ++agecounter
}


twoway (line mlm_cig_mcage3 mlm_age3 if mlm_ethnic==1, connect(ascending) sort msymbol(i) lpattern("l"))     ///
       (line mlm_cig_mcage3 mlm_age3 if mlm_ethnic==2, connect(ascending) sort msymbol(i) lpattern("_"))     ///    
	   (line mlm_cig_mcage3 mlm_age3 if mlm_ethnic==3, connect(ascending) sort msymbol(i) lpattern("dot"))   /// 
	   (line mlm_cig_mcage3 mlm_age3 if mlm_ethnic==4, connect(ascending) sort msymbol(i) lpattern("--.."))  /// 
	   ,legend(label(1 Malay) label(2 Chinese) label(3 Indian) label(4 Other bumis))         ///
	   ytitle("Predicted no. of cigarettes smoked/day") xtitle("Age")                            									 ///											
	   xscale(range(18 80) titlegap(2)) xlab(20(10)80) xmtick(##9) legend(order(1 "Malay" 2 "Chinese" 3 "Indian" 4 "Other bumis") position(1) ring(0) col(1)) ///
	   ylabel(,nogrid) graphregion(color(white)) ylab(0(5)25) ///
	   text(16 60 "p=0.034", place(se) box just(left) margin(l+2) width(15)) ///
	   title("D", size(medium))							



*Conditional cohort effect on CIG, by ethnics 
display "$S_DATE $S_TIME"
margins ethnicV2, at(mc_cohortl10=(-4.4(0.1)3.7) mc_agel10=0) expression(exp(predict(xb))) 
display "$S_DATE $S_TIME"		  

return list
matrix list r(b)
matrix B_cohort3_cig = r(b)

matrix list r(table)
matrix T_cohort3_cig = r(table)

generate mlm_cig_chrt3   = .
label variable mlm_cig_chrt3 "Margins of cig by cohort & ethnic"  

* Malay
local chrtcounter = 1916
forvalues colm = 1(5)410{
replace mlm_cig_chrt3 = B_cohort3_cig[1,`colm'] if mlm_ethnic2==1 & mlm_cohort3==`chrtcounter' 
local ++chrtcounter
}

* Chinese
local chrtcounter = 1916
forvalues colc = 2(5)410{
replace mlm_cig_chrt3 = B_cohort3_cig[1,`colc'] if mlm_ethnic2==2 & mlm_cohort3==`chrtcounter' 
local ++chrtcounter
}

* Indian
local chrtcounter = 1916
forvalues coli = 3(5)410{
replace mlm_cig_chrt3 = B_cohort3_cig[1,`coli'] if mlm_ethnic2==3 & mlm_cohort3==`chrtcounter' 
local ++chrtcounter
}

* Other bumis
local chrtcounter = 1916
forvalues colo = 4(5)410{
replace mlm_cig_chrt3 = B_cohort3_cig[1,`colo'] if mlm_ethnic2==4 & mlm_cohort3==`chrtcounter' 
local ++chrtcounter
}

* Other bumis
local chrtcounter = 1916
forvalues cols = 5(5)410{
replace mlm_cig_chrt3 = B_cohort3_cig[1,`cols'] if mlm_ethnic2==5 & mlm_cohort3==`chrtcounter' 
local ++chrtcounter
}
	
	
generate mlm_cig_u03  = .


matrix tcig3 = J( 14, 1, .)


local row = 1
forvalues c = 0/13 {
sum u0_cig if cohortgrp==`c'
matrix tcig3 [`row', 1] = r(mean)
local ++row
}


matrix list tcig3


local row = 1
forvalues c = 0/13{
replace mlm_cig_u03 = tcig3[`row', 1] if mlm_cohortgrp3==`c'
local ++row
}


generate mlm_cig_chrtu03 = exp(ln(mlm_cig_chrt3) + (mlm_cig_u03 * mlm_mccohort3l10))


      					 				
twoway (line mlm_cig_chrtu03 mlm_cohort3 if mlm_ethnic2==1, connect(ascending) sort msymbol(i) lpattern("l"))     ///
       (line mlm_cig_chrtu03 mlm_cohort3 if mlm_ethnic2==2, connect(ascending) sort msymbol(i) lpattern("_"))     ///    
	   (line mlm_cig_chrtu03 mlm_cohort3 if mlm_ethnic2==3, connect(ascending) sort msymbol(i) lpattern("dot"))   /// 
	   (line mlm_cig_chrtu03 mlm_cohort3 if mlm_ethnic2==4, connect(ascending) sort msymbol(i) lpattern("--.."))  /// 
	   ,legend(label(1 Malay) label(2 Chinese) label(3 Indian) label(4 Other bumis))         	  ///
	   ytitle("Predicted no. of cigarettes smoked/day + re") xtitle("Cohort")                    										  ///											
	   xscale(range(1910 1997) titlegap(2)) xlab(1910(20)2000) xmtick(##19) legend(order(1 "Malay" 2 "Chinese" 3 "Indian" 4 "Other bumis")  position(5) ring(0) col(1)) 	 ///
	   yscale(titlegap(2)) 	///
	   ylabel(,nogrid) graphregion(color(white)) ylab(0(5)25) ///
	   text(22 1970 "p<0.001", place(se) box just(left) margin(l+2) width(15)) ///
	   title("F", size(medium))											









