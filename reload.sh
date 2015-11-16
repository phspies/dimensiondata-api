rm *.gem
sudo gem uninstall dimensiondata-api
gem build dimensiondata.gemspec
gem install dimensiondata-2.0.0.gem
