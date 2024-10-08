#### Welcome to make_binary_colored_depression_net_maps! ####

### I developed this script because I wanted to make my own RGB color palettes for DSI studio. 
### In short, I want to color each fascicle according to whether or not it is in the depression map. Yellow is dep map, blue is non dep map (though this is flexible)

### Pre: File of fascicle overlap with depression network proportions
### Post: Output of RGB values in colors
### Uses: Opens up proportions, sorts by overlap to get a name of a vector in top quartile
###       iterate through each fascicle, if in the top quartile, color will be first color, if not, will be second color
###       **** If you change colors!!! CHANGE SUFFIX***
### Dependencies: Any R will do, need the names of the fibers in the depression network, and a file with proportions


homedir="/Users/eballer/BBL/msanxiety/"

anxiety_network_names_top_quartile_no_cranial_nerves_by_vol <- read.csv(file = paste0(homedir, "/results/anxiety_network_names_top_quartile_no_cranial_nerves_by_vol.txt"), header = F)

files = c("proportion_of_overlap_w_anxiety_net_n77", "volume_of_overlap_w_anxiety_net_n77") #c("fascicle_proportion_overlap_with_depression_network_n77")

color_anxiety_net = "132 29 226" #purple
#color_nonanxiety_net = "123 226 29" #green
color_nonanxiety_net = "211 211 211" #light grey
#color_nonanxiety_net = "0 255 255" #light blue
#color_anxiety_net = "255 255 0" #yellow
#color_nonanxiety_net = "0 0 255" #blue

for (filename in files) {
  #suffix, CHANGE IF YOU WANT A DIFFERENT FLAG
  suffix = "purple_grey"
  
  #read in file with fascicle name and proportion
  fascicle_name_and_prop <- read.csv(paste0(homedir, "/results/", filename, ".csv"), sep = ",", header = F)
  names(fascicle_name_and_prop) <- c("fascicle", "proportion")
  
  #output color file (77 lines, each represents a color), and color name vector. Not sure how to do 1:1 assignments rather than manually, but I'll see if I can figure that out!
  fascicle_name_and_prop_rgb_only <- fascicle_name_and_prop %>%
    mutate(rgb = ifelse(fascicle %in% anxiety_network_names_top_quartile_no_cranial_nerves_by_vol$V1, color_anxiety_net, color_nonanxiety_net)) %>%
    dplyr::select(fascicle, rgb)
  
  write.table(file = paste0(homedir, "/templates/dti/colors/", filename, "_", suffix, "_fascicle_names.txt"), x = fascicle_name_and_prop_rgb_only$fascicle, row.names = FALSE, col.names = FALSE, quote = FALSE)
  
  write.table(file = paste0(homedir, "/templates/dti/colors/", filename, "_", suffix, ".txt"), x = fascicle_name_and_prop_rgb_only$rgb, row.names = FALSE, col.names = FALSE, quote = FALSE)
}
