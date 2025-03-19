# Blockchain-Based Prescription Eyewear Verification

A decentralized system for verifying and managing prescription eyewear throughout its lifecycle, from medical prescription issuance to manufacturing, insurance claims, and warranty management.

## Overview

This project leverages blockchain technology to create a transparent, secure, and efficient system for managing prescription eyewear. By connecting optometrists, manufacturers, insurance providers, and patients on a unified platform, we ensure accuracy in prescription fulfillment, reduce fraud, streamline insurance claims, and simplify warranty management.

## Key Features

- **Tamper-proof prescriptions** - Securely store vision prescriptions on the blockchain
- **Manufacturing verification** - Ensure eyewear meets precise prescription specifications
- **Streamlined insurance claims** - Automate verification and processing of vision care coverage
- **Digital warranty management** - Track repairs and replacements throughout product lifecycle
- **Patient data ownership** - Give patients control over their vision health data

## Smart Contracts

### 1. Prescription Issuance Contract

Handles the creation and management of vision prescriptions issued by certified optometrists.

**Functionality:**
- Digital prescription creation and storage
- Optometrist identity verification
- Patient-controlled access management
- Prescription history tracking
- Prescription expiration management

### 2. Manufacturing Verification Contract

Ensures that manufactured eyewear meets the specifications detailed in the prescription.

**Functionality:**
- Prescription-to-manufacturing specifications mapping
- Quality control verification
- Manufacturing audit trail
- Deviation reporting and resolution
- Manufacturer certification management

### 3. Insurance Claim Contract

Manages vision insurance claims and coverage verification for prescription eyewear.

**Functionality:**
- Automated coverage verification
- Claim submission and processing
- Benefit calculation and tracking
- Fraud prevention mechanisms
- Payment processing and reconciliation

### 4. Warranty Tracking Contract

Handles repair and replacement guarantees for prescription eyewear.

**Functionality:**
- Warranty registration and activation
- Repair and replacement request processing
- Service history tracking
- Transfer of warranty with ownership changes
- Warranty expiration management

## Technical Architecture

The system combines on-chain and off-chain components to create a comprehensive solution:

- **Blockchain Layer**: Ethereum-based smart contracts for core functionality
- **User Interface**: Web and mobile applications for all stakeholders
- **Secure Storage**: IPFS integration for prescription images and detailed specifications
- **Integration Layer**: APIs to connect with existing healthcare and insurance systems
- **Privacy Layer**: Zero-knowledge proofs for sensitive patient data

## Getting Started

### Prerequisites

- Node.js (v16+)
- Truffle Suite
- MetaMask or similar web3 wallet
- Ganache (for local development)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/prescription-eyewear-verification.git
   cd prescription-eyewear-verification
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Compile smart contracts:
   ```
   truffle compile
   ```

4. Deploy to local network:
   ```
   truffle migrate --reset
   ```

### Testing

Run the automated test suite:
```
truffle test
```

## Deployment

### Local Development
1. Start Ganache local blockchain
2. Deploy contracts with `truffle migrate`
3. Configure MetaMask to connect to your local Ganache instance
4. Run the front-end with `npm start`

### Testnet/Mainnet Deployment
1. Configure your `.env` file with appropriate network credentials
2. Run `truffle migrate --network [network_name]`
3. Verify contracts on Etherscan

## Usage Examples

### Issuing a Prescription

```javascript
// Connect to the prescription issuance contract
const prescriptionContract = await PrescriptionIssuance.deployed();

// Issue a new prescription
await prescriptionContract.issuePrescription(
  patientId,
  "QmW2WQi7j...",  // IPFS hash of prescription details
  expirationDate,
  { from: optometristAddress }
);
```

### Verifying Manufacturing Specs

```javascript
// Connect to the manufacturing verification contract
const manufacturingContract = await ManufacturingVerification.deployed();

// Verify manufacturing against prescription
await manufacturingContract.verifyManufacturing(
  prescriptionId,
  "QmT2WQ...",  // IPFS hash of manufacturing specifications
  { from: manufacturerAddress }
);
```

### Filing an Insurance Claim

```javascript
// Connect to the insurance claim contract
const insuranceContract = await InsuranceClaim.deployed();

// Submit a new claim
await insuranceContract.submitClaim(
  prescriptionId,
  manufacturingVerificationId,
  claimAmount,
  "QmR3DF...",  // IPFS hash of supporting documents
  { from: patientAddress }
);
```

### Activating a Warranty

```javascript
// Connect to the warranty tracking contract
const warrantyContract = await WarrantyTracking.deployed();

// Activate warranty for new eyewear
await warrantyContract.activateWarranty(
  prescriptionId,
  manufacturingVerificationId,
  warrantyDuration,
  { from: retailerAddress }
);
```

## Stakeholder Benefits

### For Patients
- Secure storage of vision prescriptions
- Confidence in eyewear manufacturing accuracy
- Streamlined insurance claims process
- Digital warranty management

### For Optometrists
- Reduced administrative overhead
- Secure prescription management
- Improved patient trust
- Reduced liability for prescription errors

### For Manufacturers
- Clear specifications for production
- Verifiable quality control
- Reduced returns due to specification errors
- Transparent audit trail

### For Insurance Providers
- Automated verification of claims
- Reduced fraud
- Lower administrative costs
- Improved customer satisfaction

## Future Development

- Integration with electronic health record (EHR) systems
- Mobile applications for patients to manage their vision care
- Machine learning for prescription trend analysis
- Support for contact lenses and other vision correction devices
- Cross-border prescription validation

## Privacy and Compliance

The system is designed with the following considerations:

- HIPAA compliance for patient data protection
- GDPR compliance for data ownership and control
- Identity verification for healthcare providers
- Selective disclosure of patient information

## Contributing

We welcome contributions to the Blockchain-Based Prescription Eyewear Verification project!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Thanks to the Vision Care Alliance for domain expertise
- Built with support from the Healthcare Blockchain Consortium
- Special thanks to the optometrists and eyewear manufacturers who provided feedback during development
