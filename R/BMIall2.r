#' @title Compute all BMI metrics
#' 
#' Computes all available BMI metrics.
#' 
#' @param x An object of class BMIagg or BMIprc
#' @export BMIall2
#' @import data.table
#' @import vegan

BMIall2 <- function(x, effort="SAFIT2"){
  x <- data.table(x)
  result <- x[, list(
    ###Community Metrics###
    Invasive_Percent = sum(BAResult[Invasive == 1])/sum(BAResult),
    Invasive_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Invasive == 1)])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Invasive_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Invasive == 1)]),
    Taxonomic_Richness = nrow(.SD[distinct_SAFIT2=="Distinct"]),
    Shannon_Diversity = diversity(BAResult[distinct_SAFIT2=="Distinct"], index= "shannon"),
    Simpson_Diversity = diversity(BAResult[distinct_SAFIT2=="Distinct"], index= "simpson"),
    Dominant_Percent = sum(head(BAResult, 3))/sum(BAResult),
    ###Tolerance Metrics###
    Intolerant_Percent = sum(BAResult[which(ToleranceValue <= 2)])/sum(BAResult),
    Intolerant_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & ToleranceValue <= 2])/nrow(.SD[distinct_SAFIT2=="Distinct"]),
    Intolerant_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & ToleranceValue <= 2]),
    Tolerant_Percent = sum(BAResult[which(ToleranceValue >= 8)])/sum(BAResult),
    Tolerant_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & ToleranceValue >= 8])/nrow(.SD[distinct_SAFIT2=="Distinct"]),
    Tolerant_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & ToleranceValue >= 8]),
    Tolerance_Value = sum(BAResult * ToleranceValue, na.rm=T)/sum(BAResult),
    ###Feeding Group Metrics###
    CFCG_Percent = sum(BAResult[FunctionalFeedingGroup == "CF" | FunctionalFeedingGroup == "CG"])/sum(BAResult),
    CFCG_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (FunctionalFeedingGroup == "CF" | FunctionalFeedingGroup == "CG")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    CFCG_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (FunctionalFeedingGroup == "CF" | FunctionalFeedingGroup == "CG")]),
    Predator_Percent = sum(BAResult[FunctionalFeedingGroup == "P"])/sum(BAResult),
    Predator_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (FunctionalFeedingGroup == "P")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Predator_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (FunctionalFeedingGroup == "P")]),
    Scraper_Percent = sum(BAResult[FunctionalFeedingGroup == "SC"])/sum(BAResult),
    Scraper_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (FunctionalFeedingGroup == "SC")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Scraper_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (FunctionalFeedingGroup == "SC")]),
    Shredder_Percent = sum(BAResult[FunctionalFeedingGroup == "SH"])/sum(BAResult),
    Shredder_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (FunctionalFeedingGroup == "SH")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Shredder_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (FunctionalFeedingGroup == "SH")]),
    ###Habit Group Metrics###
    Burrower_Percent = sum(BAResult[which(Habit == "BU")])/sum(BAResult),
    Burrower_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Habit == "BU")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Burrower_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Habit == "BU")]),
    Climber_Percent = sum(BAResult[which(Habit == "CB")])/sum(BAResult),
    Climber_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Habit == "CB")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Climber_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Habit == "CB")]),
    Clinger_Percent = sum(BAResult[which(Habit == "CN")])/sum(BAResult),
    Clinger_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Habit == "CN")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Clinger_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Habit == "CN")]),
    Swimmer_Percent = sum(BAResult[which(Habit == "SW")])/sum(BAResult),
    Swimmer_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Habit == "SW")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Swimmer_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Habit == "SW")]),
    ###Insect Order Metrics###
    Coleoptera_Percent = sum(BAResult[Order == "Coleoptera"])/sum(BAResult),
    Coleoptera_PercentTaxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Coleoptera")])/nrow(.SD[distinct_SAFIT1=="Distinct"]), 
    Coleoptera_Taxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Coleoptera")]),
    Diptera_Percent = sum(BAResult[Order == "Diptera"])/sum(BAResult),
    Diptera_PercentTaxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Diptera")])/nrow(.SD[distinct_SAFIT1=="Distinct"]), 
    Diptera_Taxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Diptera")]),
    Ephemeroptera_Percent = sum(BAResult[Order == "Ephemeroptera"])/sum(BAResult),
    Ephemeroptera_PercentTaxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Ephemeroptera")])/nrow(.SD[distinct_SAFIT1=="Distinct"]), 
    Ephemeroptera_Taxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Ephemeroptera")]),
    EPT_Percent = sum(BAResult[Order %in% c("Ephemeroptera", "Plecoptera", "Trichoptera")])/sum(BAResult),
    EPT_PercentTaxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order %in% c("Ephemeroptera", "Plecoptera", "Trichoptera"))])/nrow(.SD[distinct_SAFIT1=="Distinct"]), 
    EPT_Taxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order %in% c("Ephemeroptera", "Plecoptera", "Trichoptera"))]),
    Plecoptera_Percent = sum(BAResult[Order == "Plecoptera"])/sum(BAResult),
    Plecoptera_PercentTaxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Plecoptera")])/nrow(.SD[distinct_SAFIT1=="Distinct"]), 
    Plecoptera_Taxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Plecoptera")]),
    Trichoptera_Percent = sum(BAResult[Order == "Trichoptera"])/sum(BAResult),
    Trichoptera_PercentTaxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Trichoptera")])/nrow(.SD[distinct_SAFIT1=="Distinct"]), 
    Trichoptera_Taxa = nrow(.SD[distinct_SAFIT1=="Distinct" & (Order == "Trichoptera")]),
    ###Chironomid Taxa Metrics###
    Chironomidae_Percent = sum(BAResult[Family == "Chironomidae"])/sum(BAResult),
    Chironomidae_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Family == "Chironomidae")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Chironomidae_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Family == "Chironomidae")]),
    Chironominae_Percent = sum(BAResult[Subfamily == "Chironominae"])/sum(BAResult),
    Chironominae_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subfamily == "Chironominae")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Chironominae_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subfamily == "Chironominae")]),
    Chironominae_PercentOfMides = sum(BAResult[Subfamily == "Chironominae"])/sum(BAResult[Family == "Chironomidae"]),
    Tanypodinae_Percent = sum(BAResult[Subfamily == "Tanypodinae"])/sum(BAResult),
    Tanypodinae_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subfamily == "Tanypodinae")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Tanypodinae_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subfamily == "Tanypodinae")]),
    Tanypodinae_PercentOfMides = sum(BAResult[Subfamily == "Tanypodinae"])/sum(BAResult[Family == "Chironomidae"]),
    Orthocladiinae_Percent = sum(BAResult[Subfamily == "Orthocladiinae"])/sum(BAResult),
    Orthocladiinae_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subfamily == "Orthocladiinae")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Orthocladiinae_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subfamily == "Orthocladiinae")]),
    Orthocladiinae_PercentOfMides = sum(BAResult[Subfamily == "Orthocladiinae"])/sum(BAResult[Family == "Chironomidae"]),
    ###Other Taxa Metrics###
    Acari_Percent = sum(BAResult[Subclass == "Acari"])/sum(BAResult),
    Acari_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subclass == "Acari")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Acari_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subclass == "Acari")]),
    Oligochaeta_Percent = sum(BAResult[Subclass == "Oligochaeta"])/sum(BAResult),
    Oligochaeta_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subclass == "Oligochaeta")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Oligochaeta_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subclass == "Oligochaeta")]),
    Amphipoda_Percent = sum(BAResult[Order == "Amphipoda"])/sum(BAResult),
    Amphipoda_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Order == "Amphipoda")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Amphipoda_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Order == "Amphipoda")]),
    Ostracoda_Percent = sum(BAResult[Order == "Ostracoda"])/sum(BAResult),
    Ostracoda_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Order == "Ostracoda")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Ostracoda_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Order == "Ostracoda")]),
    Crustacea_Percent = sum(BAResult[Subphylum == "Crustacea"])/sum(BAResult),
    Crustacea_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subphylum  == "Crustacea")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Crustacea_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Subphylum  == "Crustacea")]),
    Noninsect_Percent = sum(BAResult[Class != "Insecta"])/sum(BAResult),
    Noninsect_PercentTaxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Class != "Insecta")])/nrow(.SD[distinct_SAFIT2=="Distinct"]), 
    Noninsect_Taxa = nrow(.SD[distinct_SAFIT2=="Distinct" & (Class != "Insecta")])
  ),
              by=SampleID]
  data.frame(result)
}
