

%%%%% Donnée %%%%%%%%%%%%%%

mu=4*pi*10^-7; %permiabilité du vide
B0=1.5; %imposé
m=100; %masse
g=9.8;
P=m*g; %force en equilibre
z0=10^-2;
zm=0.02;
e=10^-2;
i0=13.5; %Courant en équilibre
im=20; %Courant max
jm=10^6; %densité de courant (1A/mm2 imposée)
rhoCU=1.8*10^(-8); %résistivité du cuivre
U=100;
sigma=59.6*10^6; %conductivité electrique cuivre
fi=50;
%%%%%%%%%%%%%%%%%%%%%%%%%

%Calcul de la profondeur p (section carrée)
p=sqrt(2*P*mu/(B0^2));

%Calcul n nombre de spires
n=B0*(zm+e)/(mu*im);

%Calcul de la section
S=p^2;

%Calcul de la section totale de la bobine
sb=im/jm;
Sb=n*sb;

%Vérification de l'effet de peau

delta=1/sqrt(sigma*pi*mu*fi);

%Calcul de l'inductance 
L1=n*B0*S/i0;

%Calcul du diametre du fil de cuivre
Dcu=sqrt(4*sb/pi); 

%Calcul de la longueur du fil
l=4*(p+2*e+sqrt(Sb)); %+

%Calcul de la résistance du fil
Rf=n*rhoCU*l/sb;

%Puissance dissipée Pdis
Pdis=Rf*i0^2;

Um=Rf*im;

%%%%%%%%%%%%%%%%%


% Composants
R=10; % Ohm -- Resistance de charge  hacheur
L=2e-3; % H -- Inductance de sortie  hacheur
C=10e-6; % F -- Capacite de sortie du hacheur
U=100; % V -- Tension d'alimentation
f=10e3; % Hz -- Frequence de commutation


% Tensions de sortie du convertiseur -> tension aux bornes de la charge
FTuC=tf([1],[L*C L/R 1]);
% Tension de sortie du convertisseur -> courant dans la charge
FTiR=FTuC/R;
% Tensions de sortie du convertiseur -> courant dans l'inductance
FTiL=tf([R*C 1],[R]).*FTuC;


tr=0.5; %s

% Correcteurs
convertisseur=tf([R*C 1],[R]).*FTuC; % fonction de transfert du convertisseur (partie courant dans l'inductance)
tau_i=0.8*R*C;
Mref_i=tf([1],[tau_i 1]); % modele de reference du hacheur
Ki=Mref_i/((1-Mref_i)*convertisseur); % correcteur 


ksi=0.7; %pour avoir un temps de réponse minimal
wn=5/tr;


Mref_z=tf([wn*wn],[1 2*ksi*wn wn*wn]);


P=tf([g],[1 0 0]);
K_z1=Mref_z/((1-Mref_z)*P);


K_zreal=minreal(-i0/2*(2/(z0+e)+K_z1)*tf([tau_i 1],[1/12500 1]));




