
**XRecon** is a lightweight domain reconnaissance tool for ethical hackers and bug bounty hunters. It helps automate the first steps of recon — quickly and cleanly.

---

## 🚀 Features

- Collect subdomains using `assetfinder`
- Perform subdomain brute-forcing using `sublist3r`
- Probe for live hosts with `httpx`
- Directory brute-forcing using `dirb`
- Simple, clean output in a single folder

---

## 📦 Requirements 

Make sure the following tools are installed on your system:

- `assetfinder`
- `sublist3r`
- `httpx`
- `dirb`

You can install them with:

```bash
sudo apt install sublist3r dirb
go install github.com/tomnomnom/assetfinder@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
