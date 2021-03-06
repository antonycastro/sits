# This is a demonstration of classification of a raster area
# The raster image is a MODIS data set covering the municipality of Sinop
# with two bands (NDVI and EVI) using MODIS collection 5 data

# Read ndvi and evi data from dropbox
# these are the symbolic links for the files at dropbox

ndvi_file <- paste0("/vsicurl/https://www.dropbox.com/s/2ckisfw7s5oyncp/Sinop_ndvi.tif?raw=1")
evi_file <- paste0("/vsicurl/https://www.dropbox.com/s/xo83mrn3jphkbmg/Sinop_evi.tif?raw=1")

# define the timeline
data(timeline_modis_392)

# create a raster metadata file based on the information about the files
raster.tb <- sits_coverage(service = "RASTER", name = "Sinop",
                           timeline = timeline_modis_392,
                           bands = c("ndvi", "evi"),
                           files = c(ndvi_file, evi_file))

#select the bands for classification
samples.tb <- sits_select(samples_MT_9classes, bands = c("ndvi", "evi"))

# get a point
point.tb <- sits_getdata(coverage = raster.tb, longitude = -55.368, latitude = -11.694)
# plot the point
sits_plot(point.tb)

# classify the raster image
raster_class.tb <- sits_classify_raster(file = "./sinop-class", raster.tb, samples.tb,
                     ml_method = sits_svm(cost = 10, kernel = "radial", tolerance = 0.001, epsilon = 0.1),
                     smoothing = FALSE, memsize = 4, multicores = 2)

# prepare data for plotting
colors <- c("#65AF72", "#d4d6ed", "#006400","#add8e6","#a0522d", "#a52a2a","#d2b48c", "#cd853f", "#ff8c00")
labels <- sits_labels(samples.tb)$label
title  <- "Classified image of SINOP MT - 2000/2001"
r <- raster_class.tb[1,]$r_objs[[1]]

# plot the first classified image
sits_plot_raster(r, title, labels, colors)


