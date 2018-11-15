%importing data
[airportf1,fs] = audioread('C:\Users\fadillahm\Desktop\project\airport_10dB\10dB\sp01_airport_sn10.wav');
[babblef1,fs] = audioread('C:\Users\fadillahm\Desktop\project\babble_10dB\10dB\sp01_babble_sn10.wav');
[carf1,fs] = audioread('C:\Users\fadillahm\Desktop\project\car_10dB\10dB\sp01_car_sn10.wav');
[exhf1,fs] = audioread('C:\Users\fadillahm\Desktop\project\exhibition_10dB\10dB\sp01_exhibition_sn10.wav');
[resf1,fs] = audioread('C:\Users\fadillahm\Desktop\project\restaurant_10dB\10dB\sp01_restaurant_sn10.wav');
[stationf1,fs] = audioread('C:\Users\fadillahm\Desktop\project\station_10dB\10dB\sp01_station_sn10.wav');
[streetf1,fs] = audioread('C:\Users\fadillahm\Desktop\project\street_10dB\10dB\sp01_street_sn10.wav');
[trainf1,fs] = audioread('C:\Users\fadillahm\Desktop\project\train_10dB\10dB\sp01_train_sn10.wav');
[cleanf,fs] = audioread('C:\Users\fadillahm\Desktop\project\clean\clean\sp01.wav');

%transpose matrix
airportf1 = airportf1.';
babblef1 = babblef1.';
carf1 = carf1.';
exhf1 = exhf1.';
resf1 = resf1.';
stationf1 = stationf1.';
streetf1 = streetf1.';
trainf1 = trainf1.';
cleanf = cleanf.';

%way to split into training set and testing set
%{
%separate into 4 training set, 1 testing set
f1_tr1 = [airportf1; babblef1];
f1_tr2 = [carf1; exhf1];
f1_tr3 = [resf1; stationf1];
f1_te = [streetf1;trainf1];
f1_tr1 = f1_tr1.';
f1_tr2 = f1_tr2.';
f1_tr3 = f1_tr3.';
f1_te = f1_te.';
cleanf = cleanf.';
cleanf = [cleanf;cleanf];


global f1_tr2;
global f1_tr3;
global f1_te;
%}
%set data into global variable
global cleanf;
global airportf1;
global babblef1;
global carf1;
global exhf1;
global stationf1;
global trainf1;
global streetf1;
global resf1;