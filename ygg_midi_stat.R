#
# THE VOICE OF YGG
# Sonification of plants
# 17-10-2024
# Enjoy
# www.biosonificaiton.altervisa.org
# www.soundcloud.com/thevoiceofygg
#

install.packages("tuneR")
library(tuneR)

#read the file
basicInfo<- tuneR::readMidi("C:/mypath/myfile.mid")
notes<-tuneR::getMidiNotes(basicInfo)

#This is where we are telling R to save our text file with the data
write.table(basicInfo,"Output location.txt",sep="\t",row.names=FALSE)
write.table(notes,"Output location2.txt",sep="\t",row.names=FALSE)



#
# Rapid calculus of Freq
#
install.packages('plyr')
library('plyr')

plyr::count(as.data.frame(notes), 'note') 
plyr::count(as.data.frame(notes), 'notename') 

#
# Detailed stats
#

install.packages("ggplot2")
library("ggplot2")

install.packages("forcats")
library(forcats)

levels(notes$notename)

#BARPLOT Notes/Count
ggplot(data=notes, aes(x= fct_infreq(notename),
       fill=fct_infreq(notename))) +
  geom_bar(width=0.5)+
  coord_flip() +
  labs(x="Notes")+
  labs(y="Count")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1))+
  theme(legend.position="none")+
  theme(text = element_text(size = 8)) 

# ALL NOTES
x<-notes$time
y<-notes$note
z<-notes$velocity
label<-notes$notename

matrice<-matrix(nrow=length(x) , ncol=3)
matrice[,1]<-x
matrice[,2]<-y
matrice[,3]<-z


mastriceD<-as.data.frame(matrice)
colnames(mastriceD) <- c("time","note", "velocity")
ggplot(mastriceD, aes(x=time, y=label)) +
  labs(y="Notes")+
  labs(x="Time ms")+
  geom_point(size=0.5, shape=21)

