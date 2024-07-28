#!/bin/bash

# Remove Previous Version Of Collector
echo "Removing previous version of collector..."
sudo systemctl stop collector
sudo systemctl stop collector_ui
sudo rm -r /opt/timpi

# Update & Security
echo "Updating and upgrading the system..."
sudo apt update && sudo apt -y upgrade


# Download the collector 0.9.0
echo "Downloading the collector 0.9.0..."
wget https://alexjenkins.tech/TimpiCollector-0-9-0-LINUX.zip -O /home/timpi/TimpiCollector-0-9-0-LINUX.zip

# Download Unzip
echo "Installing unzip..."
sudo apt install -y unzip

# Unpack The Zip Files
echo "Unpacking the collector 0.9.0..."
sudo unzip /home/timpi/TimpiCollector-0-9-0-LINUX.zip -d /home/timpi

# Install the Collector 0.9.0
echo "Installing the collector 0.9.0..."
cd /home/timpi
sudo ./install.sh

# Upgrade to the collector version 0.9.1
echo "Downloading the collector 0.9.1..."
wget https://www.alexjenkins.tech/TimpiCollector-0-9-1-LINUX.zip -O /home/timpi/TimpiCollector-0-9-1-LINUX.zip

# Unpack The Files To Timpi Directory For Upgrade
echo "Upgrading to the collector version 0.9.1..."
sudo unzip -o /home/timpi/TimpiCollector-0-9-1-LINUX.zip -d /opt/timpi

# Restart the collector UI service
echo "Restarting the collector UI service..."
sudo systemctl restart collector_ui

echo "Installation and upgrade completed. You can now open your browser and use http://localhost:5015/collector"
echo "NOTE: If the collector is not running, please remove the timpi.config file in /opt/timpi"
