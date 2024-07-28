#!/bin/bash

# Remove Previous Version Of Collector
echo "Removing previous version of collector..."
sudo systemctl stop collector || true
sudo systemctl stop collector_ui || true
sudo rm -rf /opt/timpi || true

# Update & Security
echo "Updating and upgrading the system..."
sudo apt update && sudo apt -y upgrade

# Create directory for Timpi if it doesn't exist
sudo mkdir -p /home/timpi

# Download the collector 0.9.0
echo "Downloading the collector 0.9.0..."
sudo wget https://alexjenkins.tech/TimpiCollector-0-9-0-LINUX.zip -O /home/timpi/TimpiCollector-0-9-0-LINUX.zip

# Install Unzip if not already installed
echo "Installing unzip..."
sudo apt install -y unzip

# Unpack The Zip Files
echo "Unpacking the collector 0.9.0..."
sudo unzip /home/timpi/TimpiCollector-0-9-0-LINUX.zip -d /home/timpi

# Install the Collector 0.9.0
if [ -d "/home/timpi" ]; then
  echo "Installing the collector 0.9.0..."
  cd /home/timpi || exit
  sudo ./install.sh || exit
else
  echo "Directory /home/timpi does not exist."
  exit 1
fi

# Download the collector 0.9.1
echo "Downloading the collector 0.9.1..."
sudo wget https://www.alexjenkins.tech/TimpiCollector-0-9-1-LINUX.zip -O /home/timpi/TimpiCollector-0-9-1-LINUX.zip

# Unpack The Files To Timpi Directory For Upgrade
echo "Upgrading to the collector version 0.9.1..."
sudo unzip -o /home/timpi/TimpiCollector-0-9-1-LINUX.zip -d /opt/timpi

# Restart the collector UI service
echo "Restarting the collector UI service..."
sudo systemctl restart collector_ui || true

echo "Installation and upgrade completed. You can now open your browser and use http://localhost:5015/collector"
echo "NOTE: If the collector is not running, please remove the timpi.config file in /opt/timpi"
