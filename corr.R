
#OBJECTIVE: Write a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function should return a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0.


#Download and unzipping the data

    {fileurl <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
    
    if(!file.exists("specdata.zip")){
        download.file(url = fileurl, destfile = "specdata.zip")}
    
    if(!file.exists("specdata")){
        unzip(zipfile = "specdata.zip")}}


#Producing the function
    
    corr <- function(directory, threshold = 0){
    
    #Obtaining access to files
    listfiles <- list.files(directory)
      
    #Initializing a vector 
    correlations <- vector()
      
    #Creating for loop
    for(i in 1:332){
        
        #Accessing the required monitor by forming a
        #string for the corresponding csv file.
        filename <- sprintf("%03d.csv", i)
        filepath <- paste(directory, filename, sep="/")
        data <- read.csv(filepath)
      
        #Calculate and store the count of complete cases
        completecases <- data[complete.cases(data),]
        count <- nrow(completecases)

        #Calculating correlations
        if(count >= threshold) {
        correlations <- c(correlations, cor(completecases[2],completecases[3]))
        }
    }
    
    #Produce a vector of correlations
    correlations[!is.na(correlations)]
}