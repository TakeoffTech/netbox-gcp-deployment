<div id="top"></div>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
-->


<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/TakeoffTech/netbox-gcp-deployment">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Netbox GCP installer</h3>

  <p align="center">
    This repo contains terraform and kubernetes configuration to install netbox into an empty GCP project. 
    <br />
    <a href="https://github.com/TakeoffTech/netbox-gcp-deployment"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/TakeoffTech/netbox-gcp-deployment">View Demo</a>
    ·
    <a href="https://github.com/TakeoffTech/netbox-gcp-deployment/issues">Report Bug</a>
    ·
    <a href="https://github.com/TakeoffTech/netbox-gcp-deployment/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->

This project is designed to easily deploy netbox into an GCP project in an opinonated way. 

Features: 
* Deploy netbox onto GKE autpilot cluster using the bootc helm chart: https://github.com/bootc/netbox-chart
* Use a CloudSQL posgresql for database
* Use a GCP memorystore for redis instance
* Create DNS records in managed zone
* Create SSL certs using Letsencrypt and cert-manager
* Setup and configure necessary infrastructure to support Okta authentication
  * ingress-nginx
  * vouch-proxy
  * Creates Okta OIDC application configuration via terraform
  * creates a standard set of groups in netbox after deployment

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

* [Terraform](https://terraform.io/)
* [Helm](https://helm.sh)
* [Garden](https://garden.io/)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

#### Install garden
* Homebrew on Mac
  ```sh
  brew tap garden-io/garden
  brew install garden-cli
  ```

* Installation instructions:
  https://docs.garden.io/getting-started/1-installation
#### Install and init Google Cloud SDK 
* Homebrew on Mac
  ```sh
  brew install --cask google-cloud-sdk
  ```
* For other Operating system follow the directions here:
https://cloud.google.com/sdk/docs/install

* Setting up the Google Cloud SDK
  ```sh
  gcloud init
  ```
* Make sure to login with your account and set the default login
  ```sh
  gcloud auth login
  gcloud auth application-default login
  ```
  https://cloud.google.com/sdk/docs/initializing

#### Create a GCP project
* Follow the directions here to create a gcp project:
  [Creating a project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project)

#### Create a public DNS zone in your GCP project
* this step is required if you want to setup a hostname to access netbox
* [Create a public zone](https://cloud.google.com/dns/docs/zones#create-pub-zone)

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/TakeoffTech/netbox-gcp-deployment.git
   ```

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Usage

The current setup allows you to deploy netbox to empty gcp project.

### Configuration Inputs
| Garden Variable | ENV Variable | Description | Default | Required |
|------|--------------|-------------|---------|:--------:|
| google\_project\_id | GOOGLE\_PROJECT | Google Project ID to deploy netbox too | `""` | yes |
| google\_compute\_region | GOOGLE\_REGION | Google Region to deploy netbox too | `"us-central1"` | no |
| google\_managed\_zone | MANAGED\_ZONE | Google managed zone name (not the domain name) | `""` | no |
| google\_dns\_project\_id | GOOGLE\_DNS\_PROJECT | Google Project ID that hosts the managed zone | `google_project_id` | no |
| cert\_registration\_email | CERT\_REG\_EMAIL | Letsencrypt Certification registratiobn email | `"user@example.com"` | yes |
| disable\_okta_\_auth | DISABLE\_OKTA\_AUTH | Flag to enable or disable okta oidc authentication | `true` | no |
| okta\_org\_name | OKTA\_ORG\_NAME | Okta Org name | `""` | yes (if disable_okta_auth is false) |
| okta\_base\_url | OKTA\_BASE\_URL | Okta base url | `"oktapreview.com"` | no |
| okta\_name\_prefix | OKTA\_NAME\_PREFIX | Prefix to apply to all okta resources | `""` | no |
| (ENV only variable for the okta terraform provider) | OKTA\_API\_TOKEN | Okta API token | `""` | yes (if disable_okta_auth is false) |

To set these variable before running `garden deploy` you have two options:
1. simply set the ENV variable in your shell: 
  ```sh
  export ENV_VARIABLE=myconfig
  ```
2. create a garden.env or garden.<env-name>.env file: [Variable files (varfiles)](https://docs.garden.io/using-garden/variables-and-templating#variable-files-varfiles)
  ```sh
  echo garden_variable_name=myconfig >> garden.env
  ```

### Hostname creation logic
We automatically create dns records for netbox using the `google_managed_zone` domain. 
If you are deploying into the `prod` environment, it will create `netbox.<google_managed_zone.domain>`. 
If the dns zone contains `netbox.` we assume `google_managed_zone` is a subdomain for netbox (ie `netbox.domain.local`) and will create a record just for `<google_managed_zone.domain>`. 
When you have `disable_okta_auth` set to `false` we will create a record for vouch-proxy for clients and okta to access and they are created like this `vouch.<google_managed_zone.domain>` if it's a `netbox.` subdomain. 
If it's not a subdomain it will create `vouch-netbox.<google_managed_zone.domain>` for vouch-proxy.

For development environment, replace `netbox` with `netbox-user-<local.username>`
### Setting your environment variables
* Your google project ID
  ```sh
  export GOOGLE_PROJECT=<project_id>
  ```
* We default everything to the `us-central1` region. You can override this with the `GOOGLE_REGION` environment variable. You can find the list of GCP regions here: https://cloud.google.com/compute/docs/regions-zones#available
  ```sh
  export GOOGLE_REGION=regionID
  ```
#### Deploying
* Run garden deploy
  ```sh
  garden deploy
  ```

#### Cleanup
* Delete the environment
  ```sh
  garden delete env
  ```
* Currently we do not destroy the GKE cluster when deleting the environment, run this to cleanup the project and GKE cluster
  ```sh
  garden plugins terraform destroy-root
  ```

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- ROADMAP -->
## Roadmap

- [] Feature 1
- [] Feature 2
- [] Feature 3
    - [] Nested Feature

See the [open issues](https://github.com/TakeoffTech/netbox-gcp-deployment/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/TakeoffTech/netbox-gcp-deployment](https://github.com/TakeoffTech/netbox-gcp-deployment)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/TakeoffTech/netbox-gcp-deployment.svg?style=for-the-badge
[contributors-url]: https://github.com/TakeoffTech/netbox-gcp-deployment/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/TakeoffTech/netbox-gcp-deployment.svg?style=for-the-badge
[forks-url]: https://github.com/TakeoffTech/netbox-gcp-deployment/network/members
[stars-shield]: https://img.shields.io/github/stars/TakeoffTech/netbox-gcp-deployment.svg?style=for-the-badge
[stars-url]: https://github.com/TakeoffTech/netbox-gcp-deployment/stargazers
[issues-shield]: https://img.shields.io/github/issues/TakeoffTech/netbox-gcp-deployment.svg?style=for-the-badge
[issues-url]: https://github.com/TakeoffTech/netbox-gcp-deployment/issues
[license-shield]: https://img.shields.io/github/license/TakeoffTech/netbox-gcp-deployment.svg?style=for-the-badge
[license-url]: https://github.com/TakeoffTech/netbox-gcp-deployment/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[product-screenshot]: images/screenshot.png