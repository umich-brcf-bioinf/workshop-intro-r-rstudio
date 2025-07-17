workshop_vars = list(
  ## Code of Conduct
  coc_contact = "University of Michigan Equity, Civil Rights, and Title IX Office",
  coc_contact_email = "ecrtoffice@umich.edu",

  slack_channel = "2025-07-intro-r-rstudio",

  rstudio_server_url="http://bfx-workshop02.med.umich.edu",
  rstudio_server_enddate = "7/25/2025",
  
  ssh_download_dns="bfx-workshop01.med.umich.edu",
  
  aws_s3_bucket = "https://umich-brcf-bioinf-workshop.s3.us-east-1.amazonaws.com",
  aws_s3_file = "IRR/workshop-inputs-irr.tgz"

)

# The sessionInfo outputs will only be refreshed if this var exists and we 
# are running on AWS
on_aws = dir.exists('/efs/workshop')
