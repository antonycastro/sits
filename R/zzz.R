# On load
.onAttach = function(lib, pkg){
    packageStartupMessage("SITS - A package for satellite image time series analysis.")
    packageStartupMessage(
        sprintf("Loaded sits v%s. See ?sits for help, citation(\"sits\") for use in publication.
                See demo(package = 'sits') for examples.", utils::packageDescription("sits")$Version) )
}
.onLoad = function(lib, pkg) {
    Sys.setenv(R_CONFIG_ACTIVE = "default")
    Sys.setenv(R_CONFIG_FILE = "config.yml")
    sits_config()
    sits_log()
}

# Creates a package environment to store global variables
sits.env <- new.env()

# Include the following global variables in the SITS package
utils::globalVariables(c(".", "%>%", "Index", "from", "value", "variable", "cond",
                         "med", "qt25", "qt75", "cluster_id", "x", "y",
                         "longitude", "latitude", "label", "coverage", "service",
                         "year", "start_date", "end_date", "time_series",
                         "name", "scale_factor", "missing_value",
                         "original_label", "n_members", "n_members.n", "count",
                         "segr", "frac", "total", "n", "rows.lst", "whit",
                         "blue", "red", "green", "nir", "mir", "swir",
                         "distance", "predicted", "new_values",
                         "Alig.N", "matches", "reference", "cluster", ".data"))
#' @importFrom dtw symmetric1 symmetric2
#' @importFrom lubridate %within% %m+%
#' @useDynLib sits, .registration = TRUE
NULL
