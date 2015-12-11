// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function checkUncheckAll(name, number){
  for (i = 1; i <= number; i++){
    if (document.getElementById(name+number).checked == true)
      document.getElementById(name+i).checked = true;
    else
      document.getElementById(name+i).checked = false;
  }
}

function show_school_type(school_type) {
  document.getElementById('detour_schooltype_input1').value="";
  document.getElementById('detour_schooltype_input1').hidden=true;
  document.getElementById('detour_schooltype_input2').value="";
  document.getElementById('detour_schooltype_input2').hidden=true;
  document.getElementById('detour_schooltype').value = "";
  if (school_type == 'school') {
    document.getElementById('detour_schooltype_vor1').disabled=false;
    document.getElementById('detour_schooltype_vor2').disabled=true;
  } else {
    document.getElementById('detour_schooltype_vor1').disabled=true;
    document.getElementById('detour_schooltype_vor2').disabled=false;
  }
}

function set_schooltype(school_type, schooltype_vor) {
  document.getElementById('detour_schooltype_input1').value = "";
  document.getElementById('detour_schooltype_input1').hidden=true;
  document.getElementById('detour_schooltype_input2').value = "";
  document.getElementById('detour_schooltype_input2').hidden=true;
  school_value = document.getElementById(schooltype_vor).value;
  if (school_value == 'sonstige') {
    document.getElementById('detour_schooltype').value="";
    if(school_type == 'school') {
      document.getElementById('detour_schooltype_input1').hidden=false;
    } else {
      document.getElementById('detour_schooltype_input2').hidden=false;
    }
  } else {
    document.getElementById('detour_schooltype').value = school_value;
  }
}

function write_school_type(schooltype_input) {
  schooltype_value = document.getElementById(schooltype_input).value;
  document.getElementById('detour_schooltype').value = schooltype_value;
}
      
//aus internet: 40 ist kleinste aus maximal zulässiger Anzahl für Empfänger
//falls sicher, dass man an mehrere ohne Verlust senden kann => mailto limit ändern!
function multiple_mail_to(name, number){
  var bcc_array = [];
  for (i = 1; i < number; i++){
    var element = document.getElementById(name+i);
    if (element.checked == true){
      if (bcc_array.length < 40){
        bcc_array.push(element.value);
      }else {
        location.href = "mailto:bildung@kz-gedenkstaette-dachau.de?bcc="+bcc_array.toString();
        bcc_array = [];
        bcc_array.push(element.value);
      }            
    }
  }
  if(bcc_array.length > 0) {
    location.href = "mailto:bildung@kz-gedenkstaette-dachau.de?bcc="+bcc_array.toString();
  }
}
 
//wird in Views detours/edit.html.erb und ts_request/edit.html.erb verwendet
function bestaetige_thedate(el, attr_thedate, attr_status) {      
  thedate = document.getElementById(attr_thedate)
  thedate.value=el; 
  if (document.getElementById(attr_status).value == "bestätigt") {
    if (thedate.value == "") {
      alert("Bestätigtes Datum wurde gelöscht, Status wird auf \"offen\" gesetzt!");
      document.getElementById(attr_status).value = "offen";
    } else {
      check_set_date_and_current(thedate)
    }
  }                    
}
 
//wird in workshop/edit verwendet
function best_work_thedate(attr_thedate, attr_status) {          
  if(document.getElementById(attr_thedate).value == "" &&
    document.getElementById(attr_status).value == "bestätigt"){
    alert("Bestätigtes Datum wurde gelöscht, Status wird auf \"offen\" gesetzt!");
    document.getElementById(attr_status).value = "offen";
  }                     
}

function set_date(el, attr_id) {             
  document.getElementById(attr_id).value=el; 
}
     
function set_timeto(attrfrom_id,attrto_id) {              
  var from = document.getElementById(attrfrom_id).value;
  var to = "";
  if(from != ""){
    to = plus_some_minutes(from, 150); 
  }
  document.getElementById(attrto_id).value= to;          
}

function set_to_time(attrfrom_id, attrto_id, time, event_str) {   
  var from = document.getElementById(attrfrom_id).value;
  var to = "";
  if(from != ""){
    if (event_str == 'ts_request'){
      to = "17:00"; 
    }
    else{
      to = plus_some_minutes(from, parseInt(time)); 
    }
  }
  document.getElementById(attrto_id).value= to;          
}

function set_ts_timeto(attrfrom_id,attrto_id) {       
  if(document.getElementById(attrfrom_id).value==""){
    document.getElementById(attrto_id).value="" }     
  else{ document.getElementById(attrto_id).value="17:00"}
}
 
function set_hts_timeto(attrfrom_id, attrto_id) {              
  var from = document.getElementById(attrfrom_id).value;
  var to = "";
  if(from != ""){
    to = plus_some_minutes(from, 240); 
  }
  document.getElementById(attrto_id).value = to;
}

function set_timetheto(attrfrom_id, attrto_id, attr_status) {              
  var from = document.getElementById(attrfrom_id).value;
  var to = "";
  if(from != ""){
    to = plus_some_minutes(from, 150);
  }
  document.getElementById(attrto_id).value = to;
  
  var err_text = "Eine von der Uhrzeiten des bestätigten Termins wurde gelöscht, Status wird auf \"offen\" gesetzt!"
  if(from == "" && document.getElementById(attr_status).value == "bestätigt"){
    alert( err_text);
    document.getElementById(attr_status).value = "offen";
  }        
}

function plus_some_minutes(time, minutes) {
  var times = time.split(":");
  var givenTime = new Date();
  givenTime.setHours(times[0],times[1], 0, 0);
  var plus_minutes = new Date(givenTime.getTime()+ minutes*60*1000);
  var newtime = plus_minutes.getHours()+":"+plus_minutes.getMinutes();
  if(newtime.length == 4){
    newtime += "0";
  }
  return newtime;
}
     
function check_selected_status(attr_status, attr_thedate, attr_thefrom,attr_theto) {
  if (document.getElementById(attr_status).value == "bestätigt") {
    thedate = document.getElementById(attr_thedate)
    if (thedate.value == "" ||
      document.getElementById(attr_thefrom).value == "" ||
      document.getElementById(attr_theto).value == "") {
        alert("Bevor Sie den Status auf \"bestätigt\" setzen, geben Sie das Datum und \n\
                      die Uhrzeiten des bestätigten Termins ein!");
      document.getElementById(attr_status).value = "offen";
    } else {
      check_set_date_and_current(thedate);
    }
  }     
}
          
function take_datum_detour(attr_data,attr_from,attr_to){
  document.getElementById('thedate').value = document.getElementById(attr_data).value;
  document.getElementById('detour_thedate').value = document.getElementById(attr_data).value;
  document.getElementById('detour_thefrom').value = document.getElementById(attr_from).value;
  document.getElementById('detour_theto').value = document.getElementById(attr_to).value;
         
  if( (document.getElementById('detour_thedate').value=="" ||
    document.getElementById('detour_thefrom').value=="" ||
    document.getElementById('detour_theto').value=="") &&
    document.getElementById('detour_status').value == "bestätigt"
){
    alert("Bestätigter Termin ist nicht mehr vollständig, der Status wird auf \"offen\" gesetzt!");
    document.getElementById('detour_status').value = "offen";
  }
}
function take_datum_ts_request(attr_data,attr_from,attr_to){
  document.getElementById('thedate').value = document.getElementById(attr_data).value;
  document.getElementById('ts_request_thedate').value = document.getElementById(attr_data).value;
  document.getElementById('ts_request_thefrom').value = document.getElementById(attr_from).value;
  document.getElementById('ts_request_theto').value = document.getElementById(attr_to).value;
         
  if( (document.getElementById('ts_request_thedate').value=="" ||
    document.getElementById('ts_request_thefrom').value=="" ||
    document.getElementById('ts_request_theto').value=="") &&
    document.getElementById('ts_request_status').value == "bestätigt"
){
    alert("Bestätigter Termin ist nicht mehr vollständig, der Status wird auf \"offen\" gesetzt!");
    document.getElementById('ts_request_status').value = "offen";
  }
}
     
function take_datum_htseminar(attr_data,attr_from,attr_to){
  document.getElementById('thedate').value = document.getElementById(attr_data).value;
  document.getElementById('htseminar_thedate').value = document.getElementById(attr_data).value;
  document.getElementById('htseminar_thefrom').value = document.getElementById(attr_from).value;
  document.getElementById('htseminar_theto').value = document.getElementById(attr_to).value;
         
  if( (document.getElementById('htseminar_thedate').value=="" ||
    document.getElementById('htseminar_thefrom').value=="" ||
    document.getElementById('htseminar_theto').value=="") &&
    document.getElementById('htseminar_status').value == "bestätigt"
){
    alert("Bestätigter Termin ist nicht mehr vollständig, der Status wird auf \"offen\" gesetzt!");
    document.getElementById('htseminar_status').value = "offen";
  }
}
     
function take_datum_work(attr_data, attr_from, attr_to){
  document.getElementById('thedate').value = document.getElementById(attr_data).value;
  document.getElementById('workshop_thedate').value = document.getElementById(attr_data).value;
  document.getElementById('workshop_thefrom').value = document.getElementById(attr_from).value;
  document.getElementById('workshop_theto').value = document.getElementById(attr_to).value;
         
  if( (document.getElementById('workshop_thedate').value=="" ||
    document.getElementById('workshop_thefrom').value=="" ||
    document.getElementById('workshop_theto').value=="") &&
    document.getElementById('workshop_status').value == "bestätigt"
){
    alert("Bestätigter Termin ist nicht mehr vollständig, der Status wird auf \"offen\" gesetzt!");
    document.getElementById('workshop_status').value = "offen";
  }
}
    
function check_theto_status(attrto_id,attr_status){
  var err_text = "Eine von der Uhrzeiten des bestätigten Termins wurde gelöscht, Status wird auf \"offen\" gesetzt!"
  if(document.getElementById(attrto_id).value == "" &&
    document.getElementById(attr_status).value == "bestätigt"){
    alert( err_text);
    document.getElementById(attr_status).value = "offen";
  }
}

function check_participnumber_groupnumber(attr_participnumber,attr_groupnumber){
  var err_text = "Beachten Sie bitte: eine Gruppe besteht aus 30 Personen. Es wird empfohlen "
  var partic = document.getElementById(attr_participnumber).value
  var groups = document.getElementById(attr_groupnumber).value
  var nuna = Math.floor(partic/30)
  if (partic%30 > 0 )
    nuna +=1;
  if(nuna > groups){
    err_text = err_text + nuna.toString();
    err_text = err_text + " Gruppen zu bilden."
    alert(err_text);
  }            
}
     
function prevent_empty_groupnumber(attr_groupnumber){
  var groups = document.getElementById(attr_groupnumber).value;
  if(groups == "" || groups == 0){document.getElementById(attr_groupnumber).value=1;}
}
     
function write_hl(attr_paid,attr_hl){
  if(document.getElementById(attr_paid).value == "nein" ){
    document.getElementById(attr_hl).value=""; 
    document.getElementById(attr_hl).disabled=true;          
  }
  if(document.getElementById(attr_paid).value == "ja,überwiesen"||
    document.getElementById(attr_paid).value == "ja,bar"){
    document.getElementById(attr_hl).disabled=false;          
  }
}
     
function write_foodnr(attr_food,attr_foodnumber){
  if((document.getElementById(attr_food).value == "nein") || (document.getElementById(attr_food).value == "no")){
    document.getElementById(attr_foodnumber).value=""; 
    //                    document.getElementById(attr_foodnumber).readOnly=true;  
    document.getElementById(attr_foodnumber).disabled=true;                     
  }
  if((document.getElementById(attr_food).value == "ja") || (document.getElementById(attr_food).value == "yes")){
    document.getElementById(attr_foodnumber).disabled=false; 
  }
}
     
function CheckLen(target,feld) {
  if (target.length > 255) {
    var a = target.toString().substring(0, 255);
    document.getElementById(feld).value = a;
  }
}

function CheckNames(target, feld, message){
  //    prüfen, dass der Name nur aus Buchstaben besteht, gross oder klein oder Whitespace
    
  var re = /^([a-züäöß\s\'\-])*$/i;
  if(!re.test(target)){
    var l = target.length - 1;
    var a = target.toString().substring(0, l);
    document.getElementById(feld).value = a;
    alert(message);
  }           
} 

function CheckZiffer(target, feld, message){
  var re = /^(\d)*$/i;
  if(!re.test(target)){
    var l = target.length - 1;
    var a = target.toString().substring(0, l);
    document.getElementById(feld).value = a;
    alert(message);
  }   
}

function check_set_date_and_current(thedate) {
  var date_arr = thedate.value.split("-");
  var set_date = new Date(date_arr[0], date_arr[1], date_arr[2]);
  var current_date = new Date();
  if (set_date < current_date) {
    alert("Vorsicht!\nDas bestätigte Datum darf nicht in Vergangenheit liegen")
  }
}

function check_8_grade(grade, msg) {
  var reg_exp = (/(\D|^|\A)[1-8](\D|$|\z)/);
  if (reg_exp.test(grade.toString())){
    alert(msg);
  }
}