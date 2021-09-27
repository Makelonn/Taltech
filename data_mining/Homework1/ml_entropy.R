entropy <- function(dataset, m) {
  #We will create a second table that will save the region to which the datapoint belong
  dim = ncol(dataset)
  nb_datapoint = nrow(dataset)
  max_values = matrix(,2,dim)
  phi = ceiling(m^(1/dim))
  for(d in seq(along=1:dim))
  {
    min_max_values[1,dim]=max(dataset[,dim]) #max value for this dimension
    min_max_values[2,dim]=min(dataset[,dim]) #min value for this dimension
  }
  # For exemple 2D point will be as x_coordinate, y_coordinate, grid_region_x, grid_region_y
  data_region_grid = matrix(, nrow=nb_datapoint,ncol=2*dim)
  #We select the grid region for each dimension, for each point
  for(d in seq(along=1:dim))
  {
    region_size = (min_max_values[1,dim]- min_max_values[2,dim])/phi
    for(x in seq(along=1:nb_datapoint))
    {
      #To calculate which region it is in, we take the (coordinate-min_value)/region_size
      data_region_grid[x,dim]=dataset[x,d] #We copy the dataset at the same time
      data_region_grid[x,2*dim]=((dataset[x,d]-min_max_values[2,dim])/region_size)-1
    }
  }
  for(i in seq(along=1:m))
  {
    
  }
}