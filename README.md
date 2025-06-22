
<!-- PROJECT LOGO -->
<br />
<div align="center">
    <img src="docs/banner.png" alt="Banner logo" width="450">
  </a>

  <p align="center">
     <i>Keep care of your green, leafy best friends</i>
  </p>
</div>

# About

Florae is a free application that will allow you to keep track of the care of your plants while respecting your freedom and privacy.

It is proven that having plants in rooms keeps you healthier and happier. They raise the air quality and humidity, absorb toxic substances and can improve productivity and concentration.

Growing them and taking care of them is relatively simple but requires responsibility and being aware of the requirements of irrigation, pruning, cleaning, etc. 

This app allows you to manage all the care of your plants and receive notifications when they require it.

## Features

* Easily manage your plants and the care they require.
* Set care alerts with the desired delay time.
* Consult future care for better planning.
* Open source with no hidden costs.

## Release

<a href="https://f-droid.org/es/packages/cat.naval.florae">
    <img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png"
    alt="Get it on F-Droid"
    height="80">
</a>


## Development

This application is entirely built with Flutter, and its operation is only oriented to Android devices, this is due to some dependencies used for the alerts/notifications system and the restrictions in the iOS environment to issue them without proprietary dependencies.

### Notifications

Notifications may not be delivered correctly or may not be delivered at all, because some mobile device manufacturers integrate very aggressive battery optimizations that do not respect the original Android APIs. This makes it impossible for developers to universally implement applications that run tasks in the background.

For this case a background activity is launched with a user-configurable frequency to analyze the plant database and check if any of them require attention and issue the corresponding notification.

If your device is among those affected and notifications are not displayed, please consult: [Don't kill my app!](https://dontkillmyapp.com/)

### Languages

Florae is currently translated into the following languages: `English`, `Español`, `Français`, `Nederlands`, `中文`, `Русский`, `Deutsch` and `Arabic`.

If you wish to contribute to Florae by adding a new language, just include the translation file in [`lib/l10n`](lib/l10n). I will be happy to accept your pull request.

## License

Code is released under the GNU General Public License v3.0.
