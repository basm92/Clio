#Examples of the clio package

source("./clio_get.R")
source("./clio_get_cat.R")
source("./clio_overview_cat.R")
source("./clio_overview.R")

#Try this out
clio_overview_cat("finance")

clio_overview_cat("institutions")

clio_get(c("infant mortality", "zinc production"))

clio_get(c("biodiversity - naturalness", "xecutive Constraints  (XCONST)"), 
         from = 1850, to = 1900, 
         countries = c("Armenia", "Azerbaijan"))

clio_get(c("Zinc production", "Gold production"), 
         from = 1800, to = 1920, 
         countries = c("Botswana", "Zimbabwe", 
                       mergetype = inner_join))

clio_get(c("Armed conflicts internal", "Gold production", "Armed conflicts international"), 
         mergetype = inner_join)

#The kind of merge is customizable 
#argument name: mergetype
#values: - full_join (default)
#       - left_join
#       - inner_join
#        - outer_join

clio_get_cat("finanz", list = F, from = 1800, to = 1900)

clio_overview_cat()

clio_get_cat(c("agriculture", "environment"),
             countries = "Netherlands",
             mergetype = inner_join, from = 1850, to = 1900)

clio_get_cat("Produzioni", from = 1700, list = F, mergetype = inner_join)

clio_get(c("Tin Production", "income inequality"), from = 1800, countries = c("Netherlands", "Russia"))

clio_get_cat("labor relation")
