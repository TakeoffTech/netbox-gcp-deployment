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

This project is designed to easily deploy netbox into an GCP project.

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

#### Install garden using homebrew
* Garden
  ```sh
  brew tap garden-io/garden
  brew install garden-cli
  ```
#### Create a GCP project 


### Installation

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/TakeoffTech/netbox-gcp-deployment.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

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