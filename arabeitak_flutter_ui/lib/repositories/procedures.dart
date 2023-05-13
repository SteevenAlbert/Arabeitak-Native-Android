class Procedures {
  static var proceduresList = {
    'Getting Started': [
      'Find Vehicle Identification Number (VIN)',
      'Open Car Hood',
    ],
    'Maintain Your Car': [
      'Jumpstart a Dead Battery',
      {
        'Check Your': [
          'Coolant',
          'Engine Oil',
          // 'Brake Fluid',
          'Windshield Fluid'
        ]
      },
      'Change Flat Tire',
      'Change Your Windshield Wiper Blades',
      {
        'Change Light Bulbs of': [
          'Headlights',
          'Front Turn Signal / Parking Lights',
          'Rear Turn Signal Lights',
          'Stop / Rear Side Marker / Tail Lights',
          // 'Brake Lights'
        ]
      },
      'Replace The Air Conditioning Filter',
      'Replace The Electronic Key Battery',
    ],
  };

  static var featuresList = {
    'Get More Familiar With Your Car': [
      {
        'Adjust': [
          'Front Seats',
          'Rear Seats',
        ]
      },
      'Adjust Head Restraints',
      'Adjust Outside Rear Mirror',
      'Open or Tilt Moonroof',
      'Identify Dashboard Warning Lights',
    ]
  };
}
